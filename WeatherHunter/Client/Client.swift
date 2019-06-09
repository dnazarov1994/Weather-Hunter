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
        static let baseWeatherAPI = "api.openweathermap.org/data/2.5/"
        
        case getWeather(CLLocationCoordinate2D)
        
        var stringValue: String {
            switch self {
            case .getWeather(let coordinates):
                return Endpoints.baseWeatherAPI + "weather?" + "lat=\(coordinates.latitude)&lon=\(coordinates.longitude)"
            }
        }
        
        var url:URL {
            return URL(string: stringValue)!
        }
        
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
