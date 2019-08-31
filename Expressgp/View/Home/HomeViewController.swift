//
//  HomeViewController.swift
//  Expressgp
//
//  Created by Shital Sharma on 06/05/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class HomeViewController: UIViewController,FamilyViewProtocol, CLLocationManagerDelegate {
	@IBOutlet weak var findDoctorButton: GradientButton!
	@IBOutlet weak var currentUserAddr: UIButton!
    @IBOutlet weak var mapBgView: UIView!
    @IBOutlet weak var patientButton: UIButton!
	@IBOutlet weak var dateButton: UITextField!
	@IBOutlet weak var reasonButton: UIButton!
	@IBOutlet weak var paymentOptionButton: UIButton!
    
    var findDoctorObj : FindDoctorObject?
	var locationManager = CLLocationManager() {
		didSet {
			locationManager.delegate = self
		}
	}
//
	let regionRadius: CLLocationDistance = 1000
	
	@IBOutlet weak var mapView: GMSMapView!
	var geoCoder: GMSGeocoder = GMSGeocoder()
	let datePicker: UIDatePicker = UIDatePicker()
	var selectedReason = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()
		locationManager.delegate = self
		dateButton.delegate = self
        
        
        self.mapBgView.layer.masksToBounds = false
        self.mapBgView.layer.cornerRadius = 5.0
        self.mapBgView.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.mapBgView.layer.shadowOpacity = 0.5
//		dateButton.becomeFirstResponder()
		// Check for Location Services
		self.locationManager.requestAlwaysAuthorization()
		//		// For use in foreground
		self.locationManager.requestWhenInUseAuthorization()
		presentWelcomeOverlay()
		DispatchQueue.main.async {
			self.locationManager.startUpdatingLocation()
		}
		// Do any additional setup after loading the view.
		
		self.mapView.isMyLocationEnabled = true;
		
		//Controls the type of map tiles that should be displayed.
		
		self.mapView.mapType = .normal;
		
		//Shows the compass button on the map
		
		self.mapView.settings.compassButton = true;
		
		//Shows the my location button on the map
		
		self.mapView.settings.myLocationButton = true;
		
		//Sets the view controller to be the GMSMapView delegate
		
		self.mapView.delegate = self;
        findDoctorObj = FindDoctorObject()
        
	}
	
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
		setupHomeNavigationBar()
        
        if let loginData = UserDefaults.standard.value(forKey: "UserResponse") {
            do {
                let loginObj = try JSONDecoder().decode(LoginModal.self, from: loginData as! Data)
                
                findDoctorObj?.patient_id = loginObj.data?[0].patient_id
                findDoctorObj?.user_id = loginObj.data?[0].user_id
                findDoctorObj?.appointment_date = ""
                findDoctorObj?.appointment_time = ""
                
               
            } catch let error as NSError {
                print(error.localizedDescription)
                print(error.description)
            }
        }
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		findDoctorButton.gradientLayer.frame = findDoctorButton.bounds

	}
	
	func setupHomeNavigationBar(){
		UIApplication.shared.statusBarView?.backgroundColor = Style.Color.Background.primaryColor
		self.tabBarController?.navigationItem.hidesBackButton = true
		let img = UIImage()
		navigationController?.navigationBar.shadowImage = img
		navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
		navigationController?.navigationBar.backgroundColor = Style.Color.Background.primaryColor
		navigationController?.navigationBar.barTintColor = Style.Color.Background.primaryColor
		let notifiButton = UIButton(type: .custom)
		notifiButton.setImage(UIImage(named: "notification-icon"), for: .normal)
		let rightButton = UIButton(type: .custom)
		rightButton.setTitleAndAttributes("Personal")
		self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: notifiButton)]
		let leftButton = UIButton(type: .custom)
		leftButton.setTitleAndAttributes("ExpressGP")
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
	}
	
	func validationForReason() -> Bool{
		let title = reasonButton.titleLabel?.text
		if title?.lowercased() == "reason for request" || (title?.isEmpty ?? true){
			return false
		}
		return true
	}
	
	func validationForDate() -> Bool{
		return false
	}
	
	func presentWelcomeOverlay(){
//		let overLay = FindingDoctorViewController()
//		overLay.modalPresentationStyle = .overFullScreen
		//        self.navigationController?.present(overLay, animated: true, completion: nil)
	}
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.last{
			let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 17.0)
			self.mapView.animate(to: camera)
			//Finally stop updating location otherwise it will come again and again in this delegate
			self.locationManager.stopUpdatingLocation()
		}
	}
	
	@IBAction func onsearchButtonClicked(_ sender: Any) {
		let acController = GMSAutocompleteViewController()
		// Specify a filter.
		let filter = GMSAutocompleteFilter()
		filter.type = .address
		acController.autocompleteFilter = filter
		acController.delegate = self
		self.present(acController, animated: true, completion: nil)
	}
	
	func getAddressFromLatLon(_ coordinate:CLLocationCoordinate2D){
		geoCoder.reverseGeocodeCoordinate(coordinate) { (response, error) in
			if let result = response {
				let addr:GMSAddress! = result.firstResult()
				
				if let address = addr {
					var addressString : String = ""
					if let lineAddr = address.lines?.first
					{
						addressString += lineAddr
						self.currentUserAddr.setTitle("\(addressString)".appending("."), for:.normal)
					}
					else
					{
						self.currentUserAddr.setTitle("", for: .normal)
					}
				}
			}
		}
		
	}
	@IBAction func openDatePicker(_ sender: Any) {
	}
	
	@IBAction func changePaymentOption(_ sender: Any) {
	}
	@IBAction func changePatientName(_ sender: Any) {
		let vc = UIStoryboard.init(name: "BaseViewController", bundle: nil).instantiateViewController(withIdentifier: "FamilyViewController") as? FamilyViewController
        vc?.fromView = "Home"
        vc?.delegate  = self
		vc?.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
	}
		
	@IBAction func addReasonForRequest(_ sender: Any) {
		let vc = LanguageSearchView()
		vc.delegate = self
		vc.fromText = "Existing Illness"
		self.present(vc, animated: true, completion: nil)
	}
    
    func didselectFamilyMember(familyObj : FamiliListData) {
        patientButton.setTitle("Patient : \(familyObj.relation ?? "")", for: .normal)
        findDoctorObj?.patient_id = familyObj.family_id
    }
	@IBAction func onFindDoctorTapped(_ sender: Any) {
		let isValidReason = validationForReason()
		if isValidReason{
			let overLay = FindingDoctorViewController()
			overLay.modalPresentationStyle = .overFullScreen
			self.navigationController?.present(overLay, animated: true, completion: nil)
		} else {
			let alert: UIAlertController = UIAlertController(title: "", message: "Please select a reason for request", preferredStyle: UIAlertController.Style.alert)
			alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
			self.present(alert, animated: true, completion: nil)
		}
	}
	
	@IBAction func addFavouritePlace(_ sender: Any) {
		
	}
	
	func showDateOfBirthPicker(){
		//Formate Date
		datePicker.datePickerMode = .dateAndTime
		
		//ToolBar
		let toolbar = UIToolbar();
		toolbar.sizeToFit()
		let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
		let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
		let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
		
		toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
		
		dateButton?.inputAccessoryView = toolbar
		dateButton?.inputView = datePicker
		
	}
	
	@objc func donedatePicker(){
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-dd-MM h:mm"
		dateButton.text = formatter.string(from: datePicker.date)
		self.view.endEditing(true)
	}
	
	@objc func cancelDatePicker(){
		self.view.endEditing(true)
	}
}
extension HomeViewController: LanguageSearchViewDelegate{
	func didSelectlanguage(languageObj: [LanguageData]) {
        
	}
	
	func didSelectillness(illnessObj: [IllnessData]) {
		for obj in illnessObj {
			selectedReason.append(obj.reason ?? "")
		}
		var reasonStr: String = selectedReason.joined(separator: ",")
		self.reasonButton.setTitle(reasonStr, for: .normal)
	}
	
	func didSelectiAllergies(AllergiesObj: [AllergiesData]) {
	}
	
   
}
extension HomeViewController : UITextFieldDelegate{
	func textFieldDidBeginEditing(_ textField: UITextField) {
		showDateOfBirthPicker()
	}
}
extension HomeViewController: GMSMapViewDelegate{
	func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition)
	{
		self.getAddressFromLatLon(position.target)
	}
}

extension HomeViewController: GMSAutocompleteViewControllerDelegate {
	
	func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
		
		print("Place name: \(place.name)")
		print("Place address: \(place.formattedAddress ?? "null")")
		self.currentUserAddr.setTitle(place.formattedAddress, for:.normal)
		print("Place attributions: \(String(describing: place.attributions))")
		
	}
	func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
		// TODO: handle the error.
	}
	
	// User canceled the operation.
	func wasCancelled(_ viewController: GMSAutocompleteViewController) {
		print("Autocomplete was cancelled.")
		self.dismiss(animated: true, completion: nil)
	}
}

