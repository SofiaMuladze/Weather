//
//  WeatherData.swift
//  Clima
//
//  Created by Sofia Muladze on 08/12/21.
//  
//

import UIKit


struct WeatherData: Codable {
    let name: String
    let main: Main
    let clouds: Clouds
    let weather: [Weather]
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




