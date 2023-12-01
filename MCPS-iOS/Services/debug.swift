//
//  debug.swift
//  MCPS-iOS
//
//  Created by Yuta on 2023/11/19.
//
//  Mostly from https://github.com/FromF/M5Stack-Color-BluetoothLE/tree/master

import Foundation

///デバックモード設定
func debugLog(_ obj: Any?,
              function: String = #function,
              line: Int = #line) {
    #if DEBUG
    if let obj = obj {
        print("[\(function):\(line)] : \(obj)")
    } else {
        print("[\(function):\(line)]")
    }
    #endif
}

func errorLog(_ obj: Any?,
              function: String = #function,
              line: Int = #line) {
    #if DEBUG
    if let obj = obj {
        print("ERROR [\(function):\(line)] : \(obj)")
    } else {
        print("ERROR [\(function):\(line)]")
    }
    #endif
}
