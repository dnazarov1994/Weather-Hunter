//
//  AreaInfoResponse.swift
//  WeatherHunter
//
//  Created by Dzhavid Babakishiiev on 6/11/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation

struct AreaInfoResponse: Decodable {
    var weather: [WeatherResponse]
    var temperature: TemperatureResponse
    var name: String
    
    
    enum CodingKeys: String,CodingKey {
        case weather = "weather"
        case temperature = "main"
        case name = "name"
    }
}
