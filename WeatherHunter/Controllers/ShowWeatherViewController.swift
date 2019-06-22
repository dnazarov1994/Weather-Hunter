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
    
    var coordinates: [CLLocationCoordinate2D] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = 90
        setupNavigationItem()
    }
    
    func setupNavigationItem() {
        let view = Bundle.main.loadNibNamed("NavigationTitleView", owner: nil, options: nil)?.first as! UIView
        self.navigationItem.titleView = view
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.set(coordinates: coordinates[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coordinates.count
    }
    
    
}
