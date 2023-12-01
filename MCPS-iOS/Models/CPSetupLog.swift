//
//  DeviceSetupLog.swift
//  MCPS-iOS
//
//  Created by Yuta on 2023/11/30.
//

import Foundation
import RealmSwift

class CPSetupLog: Object, Identifiable{
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var isSet: Bool
    @Persisted var location: CPLocation?
    @Persisted var eventTime: Date
    
    override init() {
        super.init()
    }
    
    init(id: String, isSet: Bool, location: CPLocation, eventTime: Date) {
        self.id = id
        self.isSet = isSet
        self.location = location
        self.eventTime = eventTime
    }
}
