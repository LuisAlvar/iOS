//
//  WeatherManager.swift
//  Clima
//
//  Created by Luis Alvarez on 1/1/26.
//  Copyright © 2026 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

/// This struct manages the networking of the calling OpenWeatherAPI for any information we require.
struct WeatherManager {
    let weatherAPIKey = Bundle.main.object(forInfoDictionaryKey: "WEATHER_API_KEY") as? String ?? ""
    let units: String = "imperial"
    let weatherURLforCity = "https://api.openweathermap.org/data/2.5/weather?q=%@&appid=%@&units=%@"
    let weatherURLforCoordinates = "https://api.openweathermap.org/data/2.5/weather?lat=%lf&lon=%lf&appid=%@&units=%@"
    
    
    var delegate: WeatherManagerDelegate? //Any class that has implemented the required function
    var cacheManager = WeatherCacheManager()
    
    /// Data-packaging from our application and perform the API call
    func fetchWeather(cityName: String)
    {
        // 1. Try cache first
        if let cached = cacheManager.getCachedWeatherModel(for: cityName) {
            print("Using cached weather for \(cityName)")
            delegate?.didUpdateWeather(self, weather: cached)
            return
        }
        // 2. Otherwise, call API
        let urlString = String(format: weatherURLforCity, cityName, weatherAPIKey, units)
        print(urlString)
        performRequest(with: urlString)
    }

    func fetchWeather(lat: Double, lon: Double)
    {
        // 1. Try cache first
        if let cached = cacheManager.getCachedWeatherModel(lat: lat, lon: lon) {
            print("Using cached weather for \(cached.cityName)")
            delegate?.didUpdateWeather(self, weather: cached)
            return
        }
        // 2. Otherwise, call API
        let urlString = String(format: weatherURLforCoordinates, lat, lon, weatherAPIKey, units)
        print(urlString)
        performRequest(with: urlString)
    }
    
    /// Main function which handles the networking for the API call along with data parsing and UI updating.
    func performRequest(with urlString: String)
    {
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = parseJSON(safeData) {
                        // let weatherVC = WeatherViewController()
                        // weatherVC.didUpdateWeather()
                        // Better way - lets use protocols and delegates
                        cacheManager.cacheWeatherModel(weather)
                        self.delegate?.didUpdateWeather(self, weather: weather) // using self because we are within a closure
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    /// Helper function which decodes the JSON string data into a Swift Object WeatherData to a final object WeatherModel
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let lon = decodedData.coord.lon
            let lat = decodedData.coord.lat
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, latitude: lat, longitude: lon)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
