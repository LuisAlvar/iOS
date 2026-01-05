//
//  WeatherCacheManager.swift
//  Clima
//
//  Created by Luis Alvarez on 1/2/26.
//  Copyright © 2026 App Brewery. All rights reserved.
//

import Foundation

/// A cache manger of our API calls to OpenWeather Service - to help us reduce the about of calls to make. 
class WeatherCacheManager {
    /// The max allocation capacity of our cached key-value data structure
    private let maxCacheSize = 5
    /// The name of our cached data structure, which is of type [String: CachedWeather]
    private let cacheKey = "weatherCacheByCity"
    /// The time expiration of a cached record, if it exists
    private let maxAge = 300.0 //seconds

    /// Wraping the WeatherModel data into this struc and attaching a timestamp to it
    struct CachedWeather: Codable {
        let weather: WeatherModel
        let timestamp: Date
    }
    
    /// The cache type data structure of [String: CachedWeather]
    private var cache: [String: CachedWeather] = [:]
    
    /// Telemetry data for how many hit our cache was successful in saving us calls to the API service
    private(set) var cacheHits = 0
    /// Telemetry data for how many misses our cache was unsucessful in not saving us calls to the API service
    private(set) var cacheMisses = 0
    
    /// Default constructor: we want to make the [String: CachedWeather] data structure
    /// within cache and have key weatherCacheByCity as a way to retreive it from cache at a later time.
    init() {
        loadCache()
    }
    
    /// For each new cached WeatherModel we will use the normailzed version of the city name as part of the key
    private func key(for cityName: String) -> String {
        return cityName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    
    /// Loading off the [String: CachedWeather] data structure from cache and saving it in our private var cache
    private func loadCache() {
        guard let data = UserDefaults.standard.data(forKey: cacheKey) else { return }
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([String:CachedWeather].self, from: data) {
            cache = decoded
        }
    }
    
    /// Saving the cache variable type [String: CachedWeather] data structure in cache
    private func saveCache() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(cache) {
            UserDefaults.standard.set(data, forKey: cacheKey)
        }
    }
    
    /// Removing the oldest entered WeatherModel onto the [String: CachedWeather] data structure
    private func evictOldest() {
        guard let oldest = cache.min(by: { $0.value.timestamp < $1.value.timestamp }) else { return }
        cache.removeValue(forKey: oldest.key)
    }
    
    /// Adding a WeatherModel ont the  [String: CachedWeather] data structure
    func cacheWeatherModel(_ weather: WeatherModel){
        let cityKey = key(for: weather.cityName)
        let cached = CachedWeather(weather: weather, timestamp: Date())
        cache[cityKey] = cached
        // if too many entries, remove the oldest one
        if cache.count > maxCacheSize {
            evictOldest()
        }
        saveCache()
    }
    
    /// Fetch WeatherModel  based on city name if it exists in cache
    func getCachedWeatherModel(for cityName: String) -> WeatherModel? {
        let cityKey = key(for: cityName)
        guard let cached = cache[cityKey] else {
            cacheMisses += 1
            return nil
        }
        let age = Date().timeIntervalSince(cached.timestamp)
        if age > maxAge {
            // Too old -> remove it and count as miss
            cache.removeValue(forKey: cityKey)
            saveCache()
            cacheMisses += 1
            return nil
        }
        // cache hit
        cacheHits += 1
        return cached.weather
    }
    
    /// Fetch WeatherModel based on lat and lon if it exists in cache
    func getCachedWeatherModel(lat: Double, lon: Double, tolerance: Double = 0.0001) -> WeatherModel? {
        for(_, cached) in cache {
            let model = cached.weather
            let modelat = model.latitude
            let modellon = model.longitude
            if abs(lat - modelat) < tolerance && abs(lon - modellon) < tolerance {
                let age = Date().timeIntervalSince(cached.timestamp)
                if age > maxAge {
                    // Too old -> remove it and count as miss
                    cache.removeValue(forKey: key(for: model.cityName))
                    saveCache()
                    cacheMisses += 1
                    return nil
                }
                cacheHits += 1
                return model
            }
        }
        cacheMisses += 1
        return nil
    }
    
    ///  Self explanatory
    func printCacheStats() {
        print("WeatherCache: Hits: \(cacheHits), Misses: \(cacheMisses)")
    }
}
