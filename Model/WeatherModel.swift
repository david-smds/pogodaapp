//
//  WeatherModel.swift
//  Pogoda
//
//  Created by Dawid Sędzimir on 15/01/2021.
//

import Foundation


struct WeatherModel {
    
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    var conditionName: String {
        
        switch conditionId {
        case 200...202:
            return "cloud.bolt.rain"
        case 210...221:
            return "cloud.bolt"
        case 230...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500, 501, 520...530:
            return "cloud.rain"
        case 502...504:
            return "cloud.heavyrain"
        case 511, 600...622:
            return "snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801,802:
            return "cloud.sun"
        case 803,804:
            return "cloud"
        default:
            return "cloud"
        
        }
        
    }
    
}


