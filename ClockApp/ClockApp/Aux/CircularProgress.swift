//
//  CircularProgress.swift
//  ClockApp
//
//  Created by Clissia Bozzer Bovi on 24/05/23.
//

import SwiftUI

struct CircularProgress: View {

    let timeInSeconds: Int
    let pastTime: Int
    let shouldShowTime: Bool
    @State var lineWidth: CGFloat = 16
    @State var color: Color = .green

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(pastTime)/CGFloat(timeInSeconds))
                .stroke(color,
                        style: StrokeStyle(
                            lineWidth: lineWidth,
                            lineCap: .round
                        ))
                .rotationEffect(.degrees(-90))
                .padding(lineWidth/2)
            if shouldShowTime {
                let seconds = pastTime % 60;
                let minutes = (pastTime / 60) % 60;
                let hours = pastTime / 3600;
                Text(String(format: "%02d:%02d:%02d", hours, minutes, seconds))
                    .bold()
                    .font(.title)
            }
        }
    }
}

struct CircularProgres_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgress(timeInSeconds: 1, pastTime: 1, shouldShowTime: true)
    }
}
