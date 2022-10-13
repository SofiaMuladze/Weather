//
//  WeatherModel.swift
//  Clima
//
//  Created by Sofia Muladze on 08/12/21.
//

import UIKit

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let humidity: Int
    let clouds: Int
    

    
    var temperatureString: String {
        return String(format: "%.f°", temperature)
    }
    var humidityString: String {
        return String("\(humidity)%")
    }
    var cloudString: String {
        return String("\(clouds)%")
    }
    

    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "6.png"
        case 300...321:
            return "4.png"
        case 500...531:
            return "5.png"
        case 600...622:
            return "7.png"
        case 701...781:
            return "8.png"
        case 800:
            return "1.png"
        case 801:
            return "2.png"
        case 802...804:
            return "3.png"
        default:
            return "3.png"
        }
    }
    
}



//struct WeatherModel {
//    let locality: String
//    let temp: String
//    let conditionId: Int
//    let humidity: Int
//    let clouds: Int
////    let hourlyWeather: [Hourly]
////    let dailyWeather: [Daily]
//
//    var tempString: String {
//        return String(format: "%.f°", temp)
//    }
//    var humidityString: String {
//        return String("\(humidity)%")
//    }
//    var cloudString: String {
//        return String("\(clouds)%")
//    }
//
//
//
////    struct Hourly {
////        var dt: String
////        let temp: String
////        let conditionId: Int
////    }
////
////    struct Daily{
////        var dt: String
////        let minTemp: String
////        let maxTemp: String
////        let conditionId: Int
////
////    }
//
//    var conditionName: String {
//        switch conditionId {
//        case 200...232:
//            return "6.png"
//        case 300...321:
//            return "4.png"
//        case 500...531:
//            return "5.png"
//        case 600...622:
//            return "7.png"
//        case 701...781:
//            return "8.png"
//        case 800:
//            return "1.png"
//        case 801:
//            return "2.png"
//        case 802...804:
//            return "3.png"
//        default:
//            return "3.png"
//        }
//    }
//}
