//
//  WeatherModel.swift
//  Clima
//
//  Created by Luis Alvarez on 1/1/26.
//  Copyright © 2026 App Brewery. All rights reserved.
//

import Foundation

/// This struct has acquire the data from an API response, and contains
/// functionality specific to the how we want to display or perform the data in our app. 
struct WeatherModel {
    
    let conditionId: Int
    let cityName: String
    let temperature: Double

    var temperatureString: String {
        String(format: "%.1f", temperature)
    }

    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
