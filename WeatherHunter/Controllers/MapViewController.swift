//
//  ViewController.swift
//  WeatherHunter
//
//  Created by Dzhavid Babakishiiev on 6/8/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var seeWeather: UIButton!
    
    var pinAnnotation: MKPointAnnotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didPress))
        mapView.addGestureRecognizer(gestureRecognizer)
        mapView.delegate = self
    }
    
    @IBAction func seeWeatherButton(_ sender: Any) {
        performSegue(withIdentifier: "nextVC", sender: nil)
    }
    
    func addAnnotation(to coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        pinAnnotation = annotation
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ShowWeatherViewController
        vc.coordinates = pinAnnotation.coordinate
    }

    
    @objc func didPress(gestureRecognizer: UIGestureRecognizer) {
        guard gestureRecognizer.state == .began else { return }
        let touchPoint = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        addAnnotation(to: coordinate)
    }

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }

}

