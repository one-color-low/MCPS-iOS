//
//  LocationManager.swift
//  MCPS-iOS
//
//  Created by Yuta on 2023/11/25.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var userLocation: CLLocation?
    
    let locationManager = CLLocationManager()
    
    // We just want the weather, so hundred meters accruacy should be good.
    static let shared = LocationManager(accuracy: kCLLocationAccuracyHundredMeters)
    
    init(accuracy: CLLocationAccuracy) {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = accuracy
    }
    
    func requestPermission() {
        if self.locationManager.authorizationStatus != .authorizedWhenInUse{
            self.locationManager.requestWhenInUseAuthorization() //
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userLocation = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways ||
            manager.authorizationStatus == .authorizedWhenInUse {
            self.locationManager.requestLocation()
        }
    }
    
}
