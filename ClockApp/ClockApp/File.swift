//
//  File.swift
//  ClockApp
//
//  Created by Bruna Lacerda on 29/05/23.
//


import Foundation
import SwiftUI
import Combine

struct City : Identifiable {
    var id = String()
    var City = String()
}

class CityStore : ObservableObject {
    @Published var city = [City]()
}
