//
//  WeatherManager.swift
//  Pogoda
//
//  Created by Dawid Sędzimir
//

import Foundation
import CoreLocation

protocol TwentyHoursWeatherManagerDelegate {
    func didUpdateWeatherThree(weather: WeatherModel)
}

struct TwentyHoursWeatherManager {
    let weatherURL =
        "https://api.openweathermap.org/data/2.5/forecast?&appid=98879bc3fcbbf4f60405935bed0dfa04&units=metric&lang=pl"
        //"https://api.openweathermap.org/data/2.5/find?&appid=98879bc3fcbbf4f60405935bed0dfa04&units=metric&lang=pl"
    
    var delegate: TwentyHoursWeatherManagerDelegate?
    
    func fetchWeatherThree(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeatherThree(latitude: CLLocationDegrees, longtitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longtitude)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        delegate?.didUpdateWeatherThree(weather: weather)
                    }
                }
            }
            
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherDataTwo.self, from: weatherData)
            let id = decodedData.list[7].weather[0].id
            let temp = decodedData.list[7].main.temp
            let name = decodedData.city.name
            
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            print(error)
            return nil
        }
        
    }
    
}

