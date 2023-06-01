//
//  NumbersView.swift
//  ClockApp
//
//  Created by Ana Elisa Lima on 30/05/23.
//

import Foundation
import SwiftUI

struct NumbersView: View {
    let numbers: [Int]
    
    var body: some View {
        ZStack {
            ForEach(0..<self.numbers.count) { index in
                let degree: Double = Double.pi * 2 / Double(self.numbers.count)
                let itemDegree = degree * Double(index)
                VStack {
                    Text("\(self.numbers[index])")
                        .font(.system(size: 35))
                        .rotationEffect(.radians(-itemDegree))
                        .foregroundColor(.white)
                    Spacer()
                }
                .rotationEffect(.radians(itemDegree))
            }
        }
    }
}
