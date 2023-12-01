//
//  SetupMode.swift
//  MCPS-iOS
//
//  Created by Yuta on 2023/11/25.
//

import Foundation
import SwiftUI

struct CPSetupModeView: View {
    
    @ObservedObject var userLocationHelper = LocationManager.shared
    
    var body: some View {
        VStack {
            Text("Setup Mode")
            Button("Load user current location") {
                loadUserCurrentLocation()
            }
        }
    }
    func loadUserCurrentLocation() {
        userLocationHelper.requestPermission()
        userLocationHelper.locationManager.requestLocation()
    }
}
