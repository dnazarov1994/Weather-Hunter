//
//  ShowWeatherViewController.swift
//  WeatherHunter
//
//  Created by Dzhavid Babakishiiev on 6/9/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class ShowWeatherViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var coordinates: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeather()
    }
    
    
    func getWeather() {
        Client.taskForGetRequest(url: Client.Endpoints.getWeather(coordinates).url , responseType: AreaInfoResponse.self) { (data, error) in
            if let data = data {
                
            }
            if let error = error {
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
}
