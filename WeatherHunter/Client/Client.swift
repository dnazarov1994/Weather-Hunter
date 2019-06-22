//
//  Client.swift
//  WeatherHunter
//
//  Created by Dzhavid Babakishiiev on 6/9/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class Client {
    
    enum Endpoints {
        private static let baseWeatherAPI = "https://api.openweathermap.org/data/2.5/"
        private static let appId = "aae9d8527c7220a6af023144808d1300"
        private static let keyAppId = "APPID=\(Endpoints.appId)"
        private static let logoWeather = "https://openweathermap.org/img/w/"
        
        case getWeather(CLLocationCoordinate2D)
        case downloadLogo(String)
        
        var stringValue: String {
            switch self {
            case .getWeather(let coordinates):
                return Endpoints.baseWeatherAPI + "weather?" + Endpoints.keyAppId + "&lat=\(coordinates.latitude)&lon=\(coordinates.longitude)"
            case .downloadLogo(let logo):
                return Endpoints.logoWeather + logo + ".png"
            }
        }
        
        var url:URL {
            return URL(string: stringValue)!
        }
        
    }
    
    class func downloadLogo(url:URL, completion:@escaping(UIImage?, Error?)-> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
                return
            }
            let logo = UIImage(data: data)
            DispatchQueue.main.async {
                completion(logo,nil)
            }
        }
        task.resume()
    }
    
    class func taskForGetRequest<ResponseType: Decodable>(url:URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?,Error?)->Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(response,nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
            }
            
        }
        task.resume()
    }
    
    
    
}
