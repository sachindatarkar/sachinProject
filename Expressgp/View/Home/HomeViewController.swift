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
	@IBOutlet weak var currentUserAddr: UILabel!
	var locationManager = CLLocationManager() {
		didSet {
			locationManager.delegate = self
		}
	}
	
	let regionRadius: CLLocationDistance = 1000
	
	@IBOutlet weak var mapView: MKMapView!
	override func viewDidLoad() {
		super.viewDidLoad()
		mapView.delegate = self
		mapView.showsUserLocation = true
		let locationManager = CLLocationManager()
		locationManager.delegate = self
		// Check for Location Services
		self.locationManager.requestAlwaysAuthorization()
		
		// For use in foreground
		self.locationManager.requestWhenInUseAuthorization()
		
		if CLLocationManager.locationServicesEnabled() {
			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
			locationManager.startUpdatingLocation()
		}
		
		
		//Zoom to user location
		if let userLocation = locationManager.location?.coordinate {
			let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
			mapView.setRegion(viewRegion, animated: false)
		}
		self.tabBarController?.title="ExpressGP"
		let notifiButton = UIButton(type: .custom)
		notifiButton.setImage(UIImage(named: "notification"), for: .normal)
		let rightButton = UIButton(type: .custom)
		rightButton.setTitle("Personal", for: .normal)
		
		self.tabBarController?.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: rightButton),UIBarButtonItem(customView: notifiButton)]
		//        self.navigationItem.title = "My Title"
		// self.navigationController?.viewControllers.first?.navigationController?.navigationBar.topItem?.title = "Shital"
		//       print(self.navigationController?.viewControllers.first?.navigationController?.navigationBar.topItem?.title)
		presentWelcomeOverlay()
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
	
	
	func presentWelcomeOverlay(){
//		let overLay = FindingDoctorViewController()
//		overLay.modalPresentationStyle = .overFullScreen
		//        self.navigationController?.present(overLay, animated: true, completion: nil)
	}
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.last{
			self.getAddressFromLatLon(Latitude: location.coordinate.latitude, Longitude: location.coordinate.longitude)
			let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
			let coordinateRegion = MKCoordinateRegion(center: center,
													  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
			self.mapView.setRegion(coordinateRegion, animated: true)
		}
	}
	
	func getAddressFromLatLon(Latitude: Double, Longitude: Double) {
		var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
		
		
		let ceo: CLGeocoder = CLGeocoder()
		center.latitude = Latitude
		center.longitude = Longitude
		
		let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
		
		
		ceo.reverseGeocodeLocation(loc, completionHandler:
			{(placemarks, error) in
				if (error != nil)
				{
					print("reverse geodcode fail: \(error!.localizedDescription)")
				}
				let pm = placemarks! as [CLPlacemark]
				
				if pm.count > 0 {
					let pm = placemarks![0]
					print(pm.country)
					print(pm.locality)
					print(pm.subLocality)
					print(pm.thoroughfare)
					print(pm.postalCode)
					print(pm.subThoroughfare)
					var addressString : String = ""
					if pm.subLocality != nil {
						addressString = addressString + pm.subLocality! + ", "
					}
					if pm.thoroughfare != nil {
						addressString = addressString + pm.thoroughfare! + ", "
					}
					if pm.locality != nil {
						addressString = addressString + pm.locality! + ", "
					}
					if pm.country != nil {
						addressString = addressString + pm.country! + ", "
					}
					if pm.postalCode != nil {
						addressString = addressString + pm.postalCode! + " "
					}
					
//					self.currentUserAddr.text = addressString
					print(addressString)
				}
		})
		
	}
}