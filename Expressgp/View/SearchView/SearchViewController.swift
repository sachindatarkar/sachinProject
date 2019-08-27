//
//  SearchViewController.swift
//  Expressgp
//
//  Created by Shital Sharma on 05/05/19.
//  Copyright © 2019 Expressgp. All rights reserved.
//

import UIKit
import GooglePlaces

class SearchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var searchTable: UITableView!
	override func viewDidLoad() {
        super.viewDidLoad()
         searchBar.delegate = self
        // Do any additional setup after loading the view.
    }

	@IBAction func onBackButtonPressed(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}
	
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		let acController = GMSAutocompleteViewController()
		// Specify the place data types to return.
//		let fields: GMSPlace = GMSPlace(rawValue: UInt(GMSPlace().nam) |
//			UInt(GMSPlaceField.placeID.rawValue))!
//		acController.placeFields = fields
		
		// Specify a filter.
		let filter = GMSAutocompleteFilter()
		filter.type = .address
		acController.autocompleteFilter = filter


		acController.delegate = self
		self.present(acController, animated: true, completion: nil)
	}
	// MARK: - Tableview
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
	
}


extension SearchViewController: GMSAutocompleteViewControllerDelegate {
	
	func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
		
		print("Place name: \(place.name)")
		print("Place address: \(place.formattedAddress ?? "null")")
		self.searchBar.text = place.formattedAddress
		print("Place attributions: \(String(describing: place.attributions))")
		
	}
	func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
		// TODO: handle the error.
//	 print("Error: \(error.description)")
//		self.dismiss(animated: true, completion: nil)
	}
	
	// User canceled the operation.
	func wasCancelled(_ viewController: GMSAutocompleteViewController) {
		print("Autocomplete was cancelled.")
		self.dismiss(animated: true, completion: nil)
	}
}

