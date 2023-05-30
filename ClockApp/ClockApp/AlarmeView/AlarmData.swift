//
//  AlarmData.swift
//  ClockApp
//
//  Created by Clissia Bozzer Bovi on 30/05/23.
//

import Foundation

struct AlarmData: Hashable {
    var etiqueta: String = "Alarme"
    var adiar: Bool
    var repetir: String
    var som: String
    var hours: Int
    var minutes: Int
}
