//
//  AdicionarAlarme.swift
//  ClockApp
//
//  Created by Pamella Alvarenga on 25/05/23.
//

import SwiftUI

struct AdicionarAlarme: View {
    
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    @State var Alarme: String = ""
    @State var adiar: Bool = true
    @State var repetir = "Nunca"
    @State var som = "Default"
//    
//    var escolhas: [Escolha] = [.init(name: "Dia da semana"),
//                               .init(name: "Som")]
////
    
    
    
    private func getPicker() -> some View {
        return HStack(spacing: 0) {
            Picker("Timer", selection: $hours) {
                ForEach((0...23), id: \.self) {
                    Text("\($0)")
                }
            } .pickerStyle(.wheel)

            
            Picker("Timer", selection: $minutes) {
                ForEach((0...59), id: \.self) {
                    Text("\($0)")
                }
            } .pickerStyle(.wheel)

        }
    }
    
    
    var body: some View {
        GeometryReader { geometry in
        //    NavigationStack {
                VStack{
                    HStack {
                        getPicker()
                    }
                    
                    List {
                        Section {
                            NavigationLink(destination: DiasDaSemana()) {
                                HStack {
                                    Text("Repetir")
                                    Spacer()
                                    Text(repetir)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            HStack {
                                Text("Etiqueta")
                                Spacer()
                                TextField("Alarme", text: $Alarme)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.gray)
                            }
                            
                            NavigationLink(destination: ListaSons()) {
                                HStack {
                                    Text("Som")
                                    Spacer()
                                    Text(som)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            HStack {
                                Toggle("Adiar", isOn: $adiar)
                            }
                        }
                    }
                    
                    
                }
         //   }
            
            
        }
    }
}

struct AdicionarAlarme_Previews: PreviewProvider {
    static var previews: some View {
        AdicionarAlarme()
    }
}
