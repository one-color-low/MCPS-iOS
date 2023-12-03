//
//  SetupMode.swift
//  MCPS-iOS
//
//  Created by Yuta on 2023/11/25.
//

import Foundation
import SwiftUI
import RealmSwift

struct CPSetupModeView: View {
    
    @ObservedObject var viewModel = CPSetupLogViewModel()
    
    @ObservedObject private var m5 = M5ViewController()
    init() {
        m5.initializeCBCentralManager()
        print("initialized")
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("設営モード")
                .bold()
            List {
                Section(header: Text("設置済み")) {
                    HStack {
                        Text("ID").bold()
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("場所").bold()
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("設置時刻").bold()
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    ForEach(viewModel.setupLogs, id: \.id) { setupLog in
                        if setupLog.isSet == true{
                            HStack {
                                Text(setupLog.id)
                                    .padding(10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("(xxx, yyy, zzz)")
                                    .padding(10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(setupLog.eventTime.description)
                                    .padding(10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                }
            }
            
            Text("あなたは今(xxx, yyy, zzz)にいます。\nここに設置しますか？")
                .multilineTextAlignment(.center)
            
            List {
                Section(header: Text("未設置")) {
                    HStack {
                        Text("ID").bold()
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("").bold()
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    // 各Personオブジェクトに対して、行を構築します。
                    ForEach(viewModel.setupLogs, id: \.id) { setupLog in
                        if setupLog.isSet == false{
                            HStack {
                                Text(setupLog.id)
                                    .padding(10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Button(action: {
                                    print(viewModel.setupLogs)
                                    print("button tapped.")
//                                    setupLog.isSet = true
                                    print(viewModel.setupLogs)
                                    let jsonText = "{type: 'SETUP', typeNo: '1.0', latitude: '1.1111', longitude: '2.2222', altitude: '3.3333'}"
                                    _ = m5.sendString(sendText: jsonText)
                                }){
                                    Text("設置する")
                                }
                                .buttonStyle(BlueRoundButtonStyle())
                            }
                        }
                    }
                }
            }
            
        }
        
        
    }
}


class CPSetupLogViewModel: ObservableObject {
    
    @Published var setupLogs: [CPSetupLog]
    
    init() {
        setupLogs = []
        let log1 = CPSetupLog(id: "aaa", isSet: true, location: CPLocation(), eventTime: Date())
        let log2 = CPSetupLog(id: "bbb", isSet: false, location: CPLocation(), eventTime: Date())
        let log3 = CPSetupLog(id: "ccc", isSet: false, location: CPLocation(), eventTime: Date())
        setupLogs.append(log1)
        setupLogs.append(log2)
        setupLogs.append(log3)
    }
    
}
