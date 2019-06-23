//
//  ViewController.swift
//  WeatherHunter
//
//  Created by Dzhavid Babakishiiev on 6/8/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var seeWeather: UIButton!
    
    var coordinates:[CLLocationCoordinate2D] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPins()
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didPress))
        mapView.addGestureRecognizer(gestureRecognizer)
        mapView.delegate = self
        seeWeather.isEnabled = false
        setupNavigationItem()
    }
    
    func loadPins() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "Pins")
        var pins: [NSManagedObject] = []
        do {
            pins = try managedContext.fetch(request)
        } catch {
            show(error: error)
        }
        pins.forEach { (object) in
            if let longitude = object.value(forKey: "longitude") as? Double,
                let latitude = object.value(forKey: "latitude") as? Double {
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                addAnnotation(to: coordinate)
            }
        }
    }
    
    func savePin(coordinate: CLLocationCoordinate2D) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Pins", in: managedContext)!
        let pin = NSManagedObject(entity: entity, insertInto: managedContext)
        
        pin.setValue(coordinate.latitude, forKey: "latitude")
        pin.setValue(coordinate.longitude, forKey: "longitude")
        do {
            try managedContext.save()
        } catch {
            show(error: error)
        }
    }
    
    
    func setupNavigationItem() {
        let view = Bundle.main.loadNibNamed("NavigationTitleView", owner: nil, options: nil)?.first as! UIView
        self.navigationItem.titleView = view
    }
    
    @IBAction func seeWeatherButton(_ sender: Any) {
        performSegue(withIdentifier: "nextVC", sender: nil)
    }
    
    func addAnnotation(to coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        coordinates.append(coordinate)
        seeWeather.isEnabled = true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ShowWeatherViewController
        vc.coordinates = coordinates
    }

    
    @objc func didPress(gestureRecognizer: UIGestureRecognizer) {
        guard gestureRecognizer.state == .began else { return }
        let touchPoint = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        savePin(coordinate: coordinate)
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

