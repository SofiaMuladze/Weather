//
//  WeatherManager.swift
//  Clima
//
//  Created by Sofia Muladze on 07/12/21.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManger: WeatherManager,  weather: WeatherModel)
    func didFailWithError (error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/onecall?appid=fc644d98bc664f44caccb04248a6fc2f&units=metric"
    //    var hourly1 = 1618315200
    //    var daily1 = 1618308000
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather (cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
        print(urlString)
    }
    func fetchWeather (longitude: CLLocationDegrees, latitude: CLLocationDegrees){
        //        let hourly = hourly1
        //        let daily = daily1
        let urlString = "\(weatherURL)&lon=\(longitude)&lat=\(latitude)"
        performRequest(with: urlString)
        print(urlString)
    }

    
    
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self  , weather: weather)
                    }
                    
                }
            }
            
            task.resume()
        }
    }
    /*
     //MARK: - ______________________
     
     
     func getWeather(onSuccess: @escaping (Result) -> Void, onError: @escaping (String) -> Void) {
     guard let url = URL(string: buildURL()) else {
     onError("Error building URL")
     return
     }
     
     let task = session.dataTask(with: url) { (data, response, error) in
     
     DispatchQueue.main.async {
     if let error = error {
     onError(error.localizedDescription)
     return
     }
     
     guard let data = data, let response = response as? HTTPURLResponse else {
     onError("Invalid data or response")
     return
     }
     
     do {
     if response.statusCode == 200 {
     let items = try JSONDecoder().decode(Result.self, from: data)
     onSuccess(items)
     } else {
     onError("Response wasn't 200. It was: " + "\n\(response.statusCode)")
     }
     } catch {
     onError(error.localizedDescription)
     }
     }
     
     }
     task.resume()
     }
     */
    //MARK: - ____________
    
    func parseJSON(_ weatherData: Data)->WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let name = "Milano"
            let temp = String(decodedData.current.temp)
            let id = decodedData.current.weather[0].id
            let humidity = decodedData.current.humidity
            let clouds = decodedData.current.clouds
            
            let hourlyDt = String(decodedData.hourly[0].dt)
            let hourlyTemp = String(decodedData.hourly[1].temp)
            let hourlyId = decodedData.hourly[2].weather[0].id
        
            let dailyDt = String(decodedData.daily[0].dt)
            let dailyMin = String(decodedData.daily[1].temp.min)
            let dailyMax = String(decodedData.daily[1].temp.max)
            let dailyId = decodedData.daily[2].weather[0].id
            
            let weather = WeatherModel(locality: name, temp: temp, conditionId: id, humidity: humidity, clouds: clouds, hourlyWeather: [WeatherModel.Hourly(dt: hourlyDt, temp: hourlyTemp, conditionId: hourlyId)], dailyWeather: [WeatherModel.Daily(dt: dailyDt, minTemp: dailyMin, maxTemp: dailyMax, conditionId: dailyId)])
            
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}


//https://api.openweathermap.org/data/2.5/weather?appid=fc644d98bc664f44caccb04248a6fc2f&units=metric&lon=139.7753269&lat=35.702069
//https://api.openweathermap.org/data/2.5/onecall?appid=fc644d98bc664f44caccb04248a6fc2f&units=metric&lon=17.122971065284013&lat=40.8520338697792&exclude=1618315200,1618308000
