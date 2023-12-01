//
//  M5TestMode.swift
//  MCPS-iOS
//
//  Created by Yuta on 2023/12/01.
//

import Foundation
import SwiftUI

struct M5TestModeView: View {
    
    @ObservedObject private var m5 = M5ViewController()
    init() {
        m5.initializeCBCentralManager()
        print("initialized")
    }
    
    var body: some View {
        VStack {
            
            Text("Send command to M5Stack.")
                .padding()
            
            Button(action:{
                _ = m5.sendString(sendText: "RED")
                print("Red Button tapped")
            }){
                Text("Red")
            }
            .padding()
            .accentColor(Color.white)
            .background(Color.red)
            .cornerRadius(26)
            
            Button(action:{
                _ = m5.sendString(sendText: "BLUE")
                print("Blue Button tapped")
            }){
                Text("BLUE")
            }
            .padding()
            .accentColor(Color.white)
            .background(Color.blue)
            .cornerRadius(26)
            
            Button(action:{
                _ = m5.sendString(sendText: "INRANGE")
                print("In Range Button tapped")
            }){
                Text("In Range")
            }
            .padding()
            .accentColor(Color.white)
            .background(Color.black)
            .cornerRadius(26)
            
            Button(action:{
                _ = m5.sendString(sendText: "OUTRANGE")
                print("Out Range Button tapped")
            }){
                Text("Out Range")
            }
            .padding()
            .accentColor(Color.white)
            .background(Color.black)
            .cornerRadius(26)
            
            Text("RSSI: "+m5.rssiStr)
                .padding()
        }
        .padding()
    }
    
}
