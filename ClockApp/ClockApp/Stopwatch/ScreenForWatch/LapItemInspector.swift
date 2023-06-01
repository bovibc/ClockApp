//
//  LapItemInspector.swift
//  ClockApp
//
//  Created by Ana Elisa Lima on 30/05/23.
//

import Foundation

struct LapItemInspector: Identifiable {
    let id = UUID()
    var lap: String = ""
    var time: String = ""
    var type: LapType = .normal
}
