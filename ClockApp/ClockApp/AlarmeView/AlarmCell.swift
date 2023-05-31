//
//  AlarmCell.swift
//  ClockApp
//
//  Created by Clissia Bozzer Bovi on 31/05/23.
//

import SwiftUI

struct AlarmCell: View {
    var alarmData: AlarmData
    @State var isOn: Bool = true
    
    var body: some View {
        let repetir = alarmData.repetir
        
        ZStack {
            HStack {
                VStack {
                    Text(String(format: "%02d:%02d", alarmData.hours, alarmData.minutes))
                        .font(.largeTitle)
                    if repetir == "Nunca" {
                        Text("\(alarmData.etiqueta)")
                            .padding(.leading, -16)
                    } else {
                        Text("\(alarmData.etiqueta), \(alarmData.repetir)")
                        .padding(.leading, -16)
                    }
                }

                Toggle("", isOn: $isOn)
            }
            .padding(.leading)
            .padding(.trailing)
            .frame(width: .infinity, height: 72)
        }
    }
}

struct AlarmCell_Previews: PreviewProvider {
    static var previews: some View {
        AlarmCell(alarmData: AlarmData(adiar: true, repetir: "Nunca", som: "", hours: 1, minutes: 1))
    }
}
