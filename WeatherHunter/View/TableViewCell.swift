//
//  TableViewCell.swift
//  WeatherHunter
//
//  Created by Dzhavid Babakishiiev on 6/14/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class TableViewCell: UITableViewCell {
  
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var fahrenheitLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var connectionFailedLabel: UILabel!
    
    @IBOutlet weak var celciusLabel: UILabel!
    
    
    func set(coordinates: CLLocationCoordinate2D) {
        connectionFailedLabel.isHidden = true
        startLoading()
        Client.taskForGetRequest(url: Client.Endpoints.getWeather(coordinates).url , responseType: AreaInfoResponse.self) { (data, error) in
            if let data = data {
                self.fill(with: data)
            }
            if error != nil {
                self.connectionFailedLabel.isHidden = false
            }
        }
    }
    
    func show(logo: String) {
        Client.downloadLogo(url: Client.Endpoints.downloadLogo(logo).url) { (image, error) in
            self.logoImage.image = image
        }
    }
    
    func fill(with info: AreaInfoResponse) {
        cityLabel.text = info.name
        let temp = converttoCelcius(kelvin: info.temperature.temperature)
        celciusLabel.text = temp.description + " C°"
        let temperature = convertToFahrenheit(kelvin: info.temperature.temperature)
        fahrenheitLabel.text = temperature.description + " F°"
        if let weather = info.weather.first {
            show(logo: weather.iconName)
        }
        stopLoading()
    }
    
    func converttoCelcius(kelvin: Double) -> Int {
        let temp = kelvin - 273.15
        return Int(temp.rounded())
    }
    
    func convertToFahrenheit(kelvin: Double) -> Int {
        let temp = 1.8 * (kelvin - 273) + 32
        return Int(temp.rounded())
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
}

