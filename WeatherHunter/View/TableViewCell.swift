//
//  TableViewCell.swift
//  WeatherHunter
//
//  Created by Dzhavid Babakishiiev on 6/14/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
  
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        startLoading()
    }
    
    
    func fill(with info: AreaInfoResponse) {
        cityLabel.text = info.name
        weatherLabel.text = info.temperature.temperature.description
        stopLoading()
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
    }
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
}

