//
//  CoinCacheManager.swift
//  ByteCoin
//
//  Created by Luis Alvarez on 1/4/26.
//  Copyright © 2026 The App Brewery. All rights reserved.
//

import Foundation

/// A cache manger of our API calls to OpenWeather Service - to help us reduce the about of calls to make.
class CoinCacheManager {
    /// The max allocation capacity of our cached key-value data structure
    private let maxCacheSize = 5
    /// The name of our cached data structure, which is of type [String: CachedCoin]
    private let cacheKey = "coinCacheByNomiation"
    /// The time expiration of a cached record, if it exists
    private let maxAge = 300.0 //seconds

    /// Wraping the CoinModel data into this struc and attaching a timestamp to it
    struct CachedCoin: Codable {
        let coin: CoinModel
        let timestamp: Date
    }

    /// The cache type data structure of [String: CachedCoin]
    private var cache: [String: CachedCoin] = [:]
    
    /// Telemetry data for how many hit our cache was successful in saving us calls to the API service
    private(set) var cacheHits = 0
    /// Telemetry data for how many misses our cache was unsucessful in not saving us calls to the API service
    private(set) var cacheMisses = 0
    
    /// Default constructor: we want to make the [String: CachedCoin] data structure
    /// within cache and have key coinCacheByNomiation as a way to retreive it from cache at a later time.
    init() {
        loadCache()
    }
    
    /// For each new cached CoinModel we will use the normailzed version of the city name as part of the key
    private func key(for currencyName: String) -> String {
        return currencyName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    
    /// Loading off the [String: CachedCoin] data structure from cache and saving it in our private var cache
    private func loadCache() {
        guard let data = UserDefaults.standard.data(forKey: cacheKey) else { return }
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([String:CachedCoin].self, from: data) {
            cache = decoded
        }
    }
    
    /// Saving the cache variable type [String: CachedCoin] data structure in cache
    private func saveCache() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(cache) {
            UserDefaults.standard.set(data, forKey: cacheKey)
        }
    }
    
    /// Removing the oldest entered CoinModel onto the [String: CachedCoin] data structure
    private func evictOldest() {
        guard let oldest = cache.min(by: { $0.value.timestamp < $1.value.timestamp }) else { return }
        cache.removeValue(forKey: oldest.key)
    }
    
    /// Adding a CoinModel ont the [String: CachedCoin] data structure
    func cacheCoinCurrency(_ coin: CoinModel){
        let coinKey = key(for: coin.asset_id_quote)
        let cached = CachedCoin(coin: coin, timestamp: Date())
        cache[coinKey] = cached
        // if too many entries, remove the oldest one
        if cache.count > maxCacheSize {
            evictOldest()
        }
        saveCache()
    }
    
    /// Fetch CoinModel  based on currency name if it exists in cache
    func getCachedCoinModel(for currencyName: String) -> CoinModel? {
        let coinKey = key(for: currencyName)
        guard let cached = cache[coinKey] else {
            cacheMisses += 1
            return nil
        }
        let age = Date().timeIntervalSince(cached.timestamp)
        if age > maxAge {
            // Too old -> remove it and count as miss
            cache.removeValue(forKey: coinKey)
            saveCache()
            cacheMisses += 1
            return nil
        }
        // cache hit
        cacheHits += 1
        return cached.coin
    }
    
    ///  Self explanatory
    func printCacheStats() {
        print("CoinCacheManager: Hits: \(cacheHits), Misses: \(cacheMisses)")
    }
}
