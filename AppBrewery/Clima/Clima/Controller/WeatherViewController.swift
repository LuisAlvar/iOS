//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    var didReceivedCoreLocation: Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Request to User for their location information
        locationManager.requestWhenInUseAuthorization()
        
        // Do any additional setup after loading the view.
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
    }
}

//MARK: - UITextFieldDelegate Section
extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    /// This type method is used for data validaton
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Please enter a city"
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // Use searchTextField.text to get the weather for that city.
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate Section
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        // Given we are trying to update the UI from a closer - after we perform an API call and parseing
        // we need to add it to a queue
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CoreLocation Section
extension WeatherViewController: CLLocationManagerDelegate {
    
    @IBAction func getCurrentLocationPressed(_ sender: UIButton) {
        didReceivedCoreLocation = false
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if !didReceivedCoreLocation {
                weatherManager.fetchWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
                manager.stopUpdatingLocation()
                didReceivedCoreLocation = true
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to get locaiton: \(error.localizedDescription)")
    }
}
