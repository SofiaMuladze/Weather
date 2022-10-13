//
//  WeatherManager.swift
//  Clima
//
//  Created by Sofia Muladze on 07/12/21.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    @IBOutlet weak var collectionEs: UICollectionView!
    @IBOutlet weak var collectionViewDays: UICollectionView!
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    

    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}


//MARK: - UITextField Delegate
extension WeatherViewController: UITextFieldDelegate{
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else{
            textField.placeholder = "Type Something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManger: WeatherManager,  weather: WeatherModel){
        DispatchQueue.main.async {
//            self.temperatureLabel.text = weather.tempString
            self.humidityLabel.text = weather.humidityString
            self.cloudsLabel.text = weather.cloudString
            self.conditionImageView.image = UIImage(named: weather.conditionName)
            self.cityLabel.text = weather.cityName
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
//    func timeStampToDate(timeStamp: NSTimeInterval) -> NSDate {
//        return NSDate(timeIntervalSince1970: timeStamp)
//    }
//    
//    func formatDate(date: NSDate) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
//        return dateFormatter.string(from: date as Date)
//    }
}

//MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(longitude: lon, latitude: lat)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionViewDays){
            return 10
        }
        
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionEs.dequeueReusableCell(withReuseIdentifier: "check", for: indexPath) as! CollectionViewCell
        if (collectionView == collectionViewDays){
            let cell2 = collectionViewDays.dequeueReusableCell(withReuseIdentifier: "checkDays", for: indexPath) as! CollectionViewCellDays
            collectionViewDays.layer.cornerRadius = 30.0
            
            return cell2
        }
        
        collectionEs.layer.cornerRadius = 30.0
        
        return cell
    }
    
}

