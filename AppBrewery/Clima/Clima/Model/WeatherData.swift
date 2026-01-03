//
//  WeatherData.swift
//  Clima
//
//  Created by Luis Alvarez on 1/1/26.
//  Copyright © 2026 App Brewery. All rights reserved.
//

import Foundation

/// This struct is used to map the OpenWeatherAPI JSON data to a Swift type object
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let pressure: Int
}

struct Weather: Codable {
    let id: Int
}
