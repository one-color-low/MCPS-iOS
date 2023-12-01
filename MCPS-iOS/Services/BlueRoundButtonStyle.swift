//
//  BlueButtonStyle.swift
//  MCPS-iOS
//
//  Created by Yuta on 2023/12/01.
//

import Foundation
import SwiftUI

struct BlueRoundButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .frame(width: 120, height: 40)
            .background(Color.blue)
            .cornerRadius(20)
    }
}
