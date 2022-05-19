//
//  WeatherData.swift
//  Clima
//
//  Created by Sofia Muladze on 08/12/21.
//  
//

import UIKit

/*
struct WeatherData: Codable {
    let name: String
    let main: Main
    let clouds: Clouds
    let weather: [Weather]
//    var hourly: [Hourly]
//    var daily: [Daily]
}


struct Main: Codable {
    let temp: Double
    let humidity: Int
}

struct Clouds: Codable {
    let all: Int
}

struct Weather: Codable {
    let id: Int
    let description: String
}
*/



struct WeatherData: Decodable{
    let current: Current
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]
}

struct Current: Decodable {
    let dt: Double
    let temp: Double
    let humidity: Int
    let clouds: Int
    let weather: [Weather]
}

struct Weather: Decodable {
    let id: Int
}

struct HourlyWeather: Decodable{
    let dt: Double
    let temp: Double
    let weather: [Weather]
}


struct DailyWeather: Decodable{
    let dt: Double
    let temp: DailyTemp
    let weather: [Weather]
}

struct DailyTemp: Decodable{
    let min: Double
    let max: Double
}



