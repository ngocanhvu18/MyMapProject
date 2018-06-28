//
//  ViewController.swift
//  MyMapProject
//
//  Created by Ngọc Anh on 6/27/18.
//  Copyright © 2018 Ngọc Anh. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import CoreLocation

class MapsViewController: UIViewController {
    
    
    @IBOutlet weak var mapsView: GMSMapView!
    @IBOutlet weak var topContrainSliderMenu: NSLayoutConstraint!
    @IBOutlet weak var sliderMenu: UIView!
    
    var locationManager: CLLocationManager = {
        var locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        }
        return locationManager
    }()
    var zoomLever: Float = 15
    var placesClient: GMSPlacesClient!
    var maker: GMSMarker!
    var curentLocation : CLLocation?
    var selectedPlace: GMSPlace?
    
    // Edit View Menu
        var isOpenSliderMenu: Bool = false {
            didSet {
                topContrainSliderMenu.constant = isOpenSliderMenu ? 0 : -(UIScreen.main.bounds.height * 1/7 + 20)
                UIView.animate(withDuration: 0.35) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Clik View Menu
                topContrainSliderMenu.constant = -(UIScreen.main.bounds.height * 1/7 + 20)
        // Ban do
        locationManager.delegate = self
        mapsView.settings.myLocationButton = true
        mapsView.settings.compassButton = true
        mapsView.isMyLocationEnabled = true
        placesClient = GMSPlacesClient.shared()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //  Click Buttun Menu
    //        @IBAction func clickMenu(_ sender: Any) {
    //            isOpenSliderMenu = !isOpenSliderMenu
    //        }
}


// xu li vi tri
extension MapsViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation =  locations.last!
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLever)
        // danh dau vi tri
        maker = nil
        mapsView.clear()
        if mapsView.isHidden {
            mapsView.isHidden = false
            mapsView.camera = camera
        } else {
            mapsView.animate(to: camera)
        }
    }
    // xu ly dieu kien xac dinh vi tri day
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch  status {
        case .restricted:
            print("Location access was restricted")
        case .denied :
            print("User denied access to location")
            // hienn thi vi tri mac dinh
            mapsView.isHidden = false
        case .notDetermined:
            print("Location status not determined")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    // xu ly bi loi
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error:\(error)")
    }
}
