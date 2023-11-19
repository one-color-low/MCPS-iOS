//
//  ContentView.swift
//  MCPS-iOS
//
//  Created by Yuta on 2023/11/19.
//

import SwiftUI

struct ContentView: View {
    let m5 = M5ViewController()
    init() {
        m5.initializeCBCentralManager()
        print("initialized")
    }
    var body: some View {
        VStack {
            Text("Change M5Stack Color")
                .padding()
            Button(action:{
                _ = m5.sendString(sendText: "RED")
                print("Red Button tapped")
            }){
                Text("Red")
            }
            .padding()
            .accentColor(Color.white)
            .background(Color.black)
            .cornerRadius(26)
            Button(action:{
                _ = m5.sendString(sendText: "BLUE")
                print("Blue Button tapped")
            }){
                Text("BLUE")
            }
            .padding()
            .accentColor(Color.white)
            .background(Color.black)
            .cornerRadius(26)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
