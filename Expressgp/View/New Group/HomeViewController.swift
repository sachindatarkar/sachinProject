//
//  HomeViewController.swift
//  Expressgp
//
//  Created by Shital Sharma on 06/05/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit
import MapKit
class HomeViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    var locationManager = CLLocationManager() {
        didSet {
            locationManager.delegate = self
        }
    }

    @IBOutlet weak var searchView: UIView!
    let regionRadius: CLLocationDistance = 1000

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.searchView.layer.masksToBounds = false
        self.searchView.layer.cornerRadius = 25
        self.searchView.layer.shadowRadius = 3.0
        self.searchView.layer.shadowOpacity = 0.5
        self.searchView.layer.shadowColor = UIColor.black.cgColor
        mapView.delegate = self
        mapView.showsUserLocation = true
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        
        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(viewRegion, animated: false)
        }
        print(self.navigationItem)
//        self.navigationItem.topItem?.title = "Test"
       self.navigationController?.viewControllers.first?.navigationController?.navigationBar.topItem?.title = "Shital"
       print(self.navigationController?.viewControllers.first?.navigationController?.navigationBar.topItem?.title)

        self.locationManager = locationManager
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
           
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let coordinateRegion = MKCoordinateRegion(center: center,
                                                      latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            self.mapView.setRegion(coordinateRegion, animated: true)
        }
    }
}
