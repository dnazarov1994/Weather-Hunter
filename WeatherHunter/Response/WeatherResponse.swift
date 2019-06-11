//
//  WeatherResponse.swift
//  WeatherHunter
//
//  Created by Dzhavid Babakishiiev on 6/11/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation


struct WeatherResponse:Decodable {
    var description: String
    var iconName: String
    
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case iconName = "icon"
    }
}

