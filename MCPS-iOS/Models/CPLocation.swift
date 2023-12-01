//
//  Location.swift
//  MCPS-iOS
//
//  Created by Yuta on 2023/11/30.
//

import Foundation
import RealmSwift

class CPLocation: Object {
    @Persisted var latitude: Float = 0.0
    @Persisted var longitude: Float = 0.0
    @Persisted var altitude: Float = 0.0
}
