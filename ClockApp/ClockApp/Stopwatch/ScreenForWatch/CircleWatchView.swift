//
//  CircleWatchView.swift
//  ClockApp
//
//  Created by Ana Elisa Lima on 30/05/23.
//

import SwiftUI

struct CircleWatchView: View {
    private let marginLeading: CGFloat = 16
    private let marginTrailing: CGFloat = 16
    private let marginTop: CGFloat = 12
    private let tickHeight: CGFloat = 8
    private let longTickHeight: CGFloat = 14
    private let tickWidth: CGFloat = 2
    private let numberPadding: CGFloat = 40
    private let actionButtonPadding: CGFloat = 16
    @State private var laps: [Int] = []
    @ObservedObject private var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            GeometryReader { geometryReader in
                VStack {
                    ZStack {
                        let width = geometryReader.size.width
                        - self.marginLeading
                        - self.marginTrailing
                        ClockView(count: 240,
                                  longDivider: 4,
                                  longTickHeight: self.longTickHeight,
                                  tickHeight: self.tickHeight,
                                  tickWidth: self.tickWidth,
                                  highlightedColorDivider: 20,
                                  highlightedColor: .clockHighlightedLineColor,
                                  normalColor: .clockLineColor)
                        .frame(width: width, height: width)
                        
                        let numbersWidth = width - self.numberPadding
                        NumbersView(numbers: self.getNumbers(count: 12))
                            .frame(width: numbersWidth, height: numbersWidth)
                        
                        Text(self.viewModel.currentLapTime)
                            .padding(.top, width * 0.39)
                        
                        NeedleView(width: 8, height: width, color: .needleNormal,bottomLineHeight: 30)
                            .rotationEffect(.radians(Double.pi / 2))
                        
                        HStack {
                            if viewModel.isLapStarted {
                                GenericButton(type: .lap, action: viewModel.rightButtonTapped)
                            } else {
                                GenericButton(type: .reset, action: viewModel.leftButtonTapped)
                            }
                            
                            Spacer()
                            
                            if viewModel.isLapStarted {
                                GenericButton(type: .stop, action: viewModel.rightButtonTapped)
                            } else {
                                GenericButton(type: .initiate, action: viewModel.rightButtonTapped)
                            }
                        }
                        .padding(.top, width + self.actionButtonPadding)
                    }
                    .padding(.leading, self.marginLeading)
                    .padding(.trailing, self.marginTrailing)
                    .padding(.top, self.marginTop)
                    
                    List {
                        ForEach(self.viewModel.presenters) { item in
                            VStack(alignment: .leading, spacing: 12) {
                                Color.lapCellSeparator.frame(width: geometryReader.size.width, height: 1)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func getNumbers(count: Int) -> [Int] {
        var numbers: [Int] = []
        numbers.append(count * 5)
        for index in 1..<count {
            numbers.append(index * 5)
        }
        return numbers
    }
}
  

struct CircleWatchView_Previews: PreviewProvider {
    static var previews: some View {
        CircleWatchView()
    }
}
