//
//  ConnectModeView.swift
//  MCPS-iOS
//
//  Created by Yuta on 2023/11/25.
//

import Foundation
import SwiftUI

struct CheckInModeView: View {
    
    @ObservedObject private var m5 = M5ViewController()
    init() {
        m5.initializeCBCentralManager()
        print("initialized")
    }
    
    @ObservedObject var viewModel = CheckInLogViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Check-In モード")
                .bold()
            Spacer()
            
            HStack{
                Text("User ID: \nxxx")
                    .multilineTextAlignment(.center)
                Button(action: {
                    print("button tapped.")
                }){
                    Text("変更する")
                }
                .buttonStyle(BlueRoundButtonStyle())
            }
            
            List {
                Section(header: Text("Check-In履歴")) {
                    HStack {
                        Text("ID").bold()
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("").bold()
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    ForEach(viewModel.checkInLogs, id: \.id) { checkInLog in
                        HStack {
                            Text(checkInLog.id)
                                .padding(10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(checkInLog.eventTime.description)
                                .padding(10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                
            }
            
            Text("ポイントxxxxの近くにいます")
            Text("RSSI: -80dBm")
            
            Spacer()
            
            Button(action: {
                print("button tapped.")
            }){
                Text("Check-In")
            }
            .buttonStyle(BlueRoundButtonStyle())
        }

    }
    
}

class CheckInLogViewModel: ObservableObject {
    
    @Published var checkInLogs: [CheckInLog]
    
    init() {
        checkInLogs = []
        let log1 = CheckInLog()
        let log2 = CheckInLog()
        checkInLogs.append(log1)
        checkInLogs.append(log2)
    }
    
}
