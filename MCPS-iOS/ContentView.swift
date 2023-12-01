//
//  ContentView.swift
//  MCPS-iOS
//
//  Created by Yuta on 2023/11/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            TabView()  {
                CPSetupModeView()
                    .tabItem {
                        Image(systemName: "gear")
                    }
                CheckInModeView()
                    .tabItem {
                        Image(systemName: "app.connected.to.app.below.fill")
                    }
            }

        }
    }
}

#Preview {
    ContentView()
}
