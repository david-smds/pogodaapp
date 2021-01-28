//
//  WeatherData.swift
//  Pogoda
//
//  Created by Dawid Sędzimir 
//

import Foundation

struct WeatherData: Codable {
    
    let list: [List]
    
    
}

struct List: Codable {
    let name: String
    let id: Int
    let dt: Int
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let sys: Sys
}

struct Main: Codable {
    let temp: Double
    let pressure: Double
}
struct Weather: Codable {
    let description: String
    let main: String
    let id: Int
}

struct Wind: Codable {
    let speed: Double
}

struct Sys: Codable {
    let country: String
}

struct WeatherDataTwo: Codable {
    
    let city: City
    let list: [ListTwo]
}

struct City: Codable {
    let name: String
}

struct ListTwo: Codable {
    
    let main: MainTwo
    let weather: [WeatherTwo]
    
}

struct MainTwo: Codable {
    let temp: Double
}
struct WeatherTwo: Codable {
    let id: Int
}
//list[16].main.temp
//city.name
