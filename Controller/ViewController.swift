//
//  ViewController.swift
//  Pogoda
//
//  Created by Dawid Sędzimir
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        weatherManagerThree.delegate = self
        twelveHoursWeatherManager.delegate = self
        weatherManager.delegate = self
        searchTextField.delegate = self

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

