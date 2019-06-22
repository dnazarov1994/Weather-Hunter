//
//  TemperatureResponse.swift
//  WeatherHunter
//
//  Created by Dzhavid Babakishiiev on 6/11/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation

struct TemperatureResponse: Decodable {
    var temperature: Double
    
    enum CodingKeys: String, CodingKey{
        case temperature = "temp"
    }
}
