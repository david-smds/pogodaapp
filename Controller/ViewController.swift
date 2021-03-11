//
//  ViewController.swift
//  Pogoda
//
//  Created by Dawid Sędzimir
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate, TwelveHoursWeatherManagerDelegate, TwentyHoursWeatherManagerDelegate {

    @IBOutlet weak var currentConditionImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var nextDayLabel: UILabel!
    @IBOutlet weak var nextDayConditionImageView: UIImageView!
    @IBOutlet weak var nextDayTemperatureLabel: UILabel!
    @IBOutlet weak var thirdDayLabel: UILabel!
    @IBOutlet weak var thirdDayConditionImageView: UIImageView!
    @IBOutlet weak var thirdDayTemperatureLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    var twelveHoursWeatherManager = WeatherManagerTwo()
    var weatherManagerThree = TwentyHoursWeatherManager()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManagerThree.delegate = self
        twelveHoursWeatherManager.delegate = self
        weatherManager.delegate = self
        searchTextField.delegate = self

    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        
        locationManager.requestLocation()
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Wpisz nazwę"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
            twelveHoursWeatherManager.fetchWeatherTwo(cityName: city)
            weatherManagerThree.fetchWeatherThree(cityName: city)
        }
        
        searchTextField.text = ""
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        
        DispatchQueue.main.async {
            
            self.temperatureLabel.text = weather.temperatureString
            self.currentConditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            
        }

    }

    func didUpdateWeatherTwo(weather: WeatherModel) {
        
        DispatchQueue.main.async {
            
            self.nextDayTemperatureLabel.text = weather.temperatureString
            self.nextDayConditionImageView.image = UIImage(systemName: weather.conditionName)
            self.nextDayLabel.text = "In 12 hrs"
            
        }
        
    }
    
    func didUpdateWeatherThree(weather: WeatherModel) {
        
        DispatchQueue.main.async {
            
            self.thirdDayTemperatureLabel.text = weather.temperatureString
            self.thirdDayConditionImageView.image = UIImage(systemName: weather.conditionName)
            self.thirdDayLabel.text = "In 24 hrs"
            
        }
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let latitude = location.coordinate.latitude
            let longtitude = location.coordinate.longitude
            
            weatherManager.fetchWeather(latitude: latitude, longtitude: longtitude)
            twelveHoursWeatherManager.fetchWeatherTwo(latitude: latitude, longtitude: longtitude)
            weatherManagerThree.fetchWeatherThree(latitude: latitude, longtitude: longtitude)
            
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
