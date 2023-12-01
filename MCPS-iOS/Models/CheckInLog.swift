//
//  CheckInLog.swift
//  MCPS-iOS
//
//  Created by Yuta on 2023/11/30.
//

import Foundation
import RealmSwift

class CheckInLog: Object{
    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var eventTime: Date = Date()
}
