//
//  GenericButton.swift
//  ClockApp
//
//  Created by Clissia Bozzer Bovi on 29/05/23.
//

import SwiftUI

enum ButtonType: String {
    case stop = "Parar"
    case reset = "Resetar"
    case initiate = "Iniciar"
    case lap = "Volta"
    case resume = "Retomar"
    case pause = "Pausar"
    case cancel = "Cancelar"
}

struct GenericButton: View {
    var type: ButtonType
    var isTimerRunning: Bool = true
    var action: (() -> Void)?

    var pauseColor: Color = Color(uiColor: UIColor(red: 241/255, green: 164/255, blue: 60/255, alpha: 1))

    var cancelButtonColor: Color {
        return !isTimerRunning ? .gray : .white
    }

    private func getForegroundColor() -> Color {
        switch type {
        case .stop:
            return .white
        case .reset:
            return .white
        case .initiate, .pause, .resume:
            return .white
        case .lap:
            return .white
        case .cancel:
            return cancelButtonColor
        }
    }

    private func getBackgroundColor() -> Color {
        switch type {
        case .stop:
            return .red
        case .initiate, .resume:
            return .green
        case .pause:
            return pauseColor
        case .cancel, .lap, .reset:
            return .gray
        }
    }

    var body: some View {
        Button {
            action?()
        } label: {
            Text(type.rawValue)
                .frame(width: 70, height: 70)
                .foregroundColor(getForegroundColor())
                .background(getBackgroundColor()).opacity(0.8)
                .clipShape(Circle())
                .padding(.all, 3)
                .overlay(
                    Circle()
                        .stroke(getBackgroundColor())
                        .opacity(0.7))
        }
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        GenericButton(type: .cancel, isTimerRunning: true)
    }
}
