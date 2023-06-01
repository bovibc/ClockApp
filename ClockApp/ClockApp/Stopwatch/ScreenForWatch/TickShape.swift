//
//  TickShape.swift
//  ClockApp
//
//  Created by Ana Elisa Lima on 30/05/23.
//

import Foundation
import SwiftUI

struct TickShape: Shape {
    let tickHeight: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + self.tickHeight))
        return path
    }
}

