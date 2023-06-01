//
//  AlarmCell.swift
//  ClockApp
//
//  Created by Clissia Bozzer Bovi on 31/05/23.
//

import SwiftUI

struct AlarmCell: View {

    @State var isOn: Bool = true
    var alarmData: AlarmData
    var color: Color {
        return isOn ? .white : .gray
    }
    
    var body: some View {
        let repetir = alarmData.repetir
        
            HStack{
                VStack(alignment: .leading) {
                    Text(String(format: "%02d:%02d", alarmData.hours, alarmData.minutes))
                        .font(.largeTitle)
                        .foregroundColor(color)
                        .multilineTextAlignment(.leading)
                    if repetir == "Nunca" {
                        Text("\(alarmData.etiqueta)")
                            .foregroundColor(color)
                            .multilineTextAlignment(.leading)
                    } else {
                        Text("\(alarmData.etiqueta), \(alarmData.repetir)")
                            .foregroundColor(color)
                            .multilineTextAlignment(.leading)
                    }
                }
                Toggle("", isOn: $isOn)
                    .multilineTextAlignment(.trailing)
            }
            .padding(.leading)
            .padding(.trailing)
            .frame(width: .infinity, height: 72)
        
    }
}

struct AlarmCell_Previews: PreviewProvider {
    static var previews: some View {
        AlarmCell(alarmData: AlarmData(adiar: true, repetir: "Nunca", som: "", hours: 1, minutes: 1))
    }
}
