//
//  AlarmeView.swift
//  ClockApp
//
//  Created by Pamella Alvarenga on 23/05/23.
//

import SwiftUI

struct AlarmeView: View {
    
    let bedImage = UIImage(systemName: "bed.double.fill.mine")
    @State private var showingSheet = false
    @Environment(\.presentationMode) var presententionMode
    @State private var list: Array<AlarmData> = []
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    @State var alarme: String = ""
    @State var adiar: Bool = true
    @State var repetir = "Nunca"
    @State var som = "Default"
    
    private let defaultRepetir: String = "Nunca"
    private let defaultAlarme: String = "Alarme"
    private let defaultSom: String = "Default"
    private let defaultAdiar: Bool = true
    
    private func getPicker() -> some View {
        return HStack(spacing: 0) {
            Picker("Timer", selection: $hours) {
                ForEach((0...23), id: \.self) {
                    Text("\($0)").listRowBackground(Color.orange)
                }
            } .pickerStyle(.wheel)
            
            
            Picker("Timer", selection: $minutes) {
                ForEach((0...59), id: \.self) {
                    Text("\($0)")
                }
            } .pickerStyle(.wheel)
            
        }
    }
    
    private func addElement() {
        if alarme == "" { alarme = defaultAlarme }
        let alarm = AlarmData(etiqueta: alarme, adiar: adiar, repetir: repetir, som: som, hours: hours, minutes: minutes)
        list.append(alarm)
        setDefaultValues()
        showingSheet = false
    }
    
    private func setDefaultValues() {
        alarme = defaultAlarme
        adiar = defaultAdiar
        repetir = defaultRepetir
        som = defaultSom
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView{
                Label("Dormir|Acordar", systemImage: "bed.double.fill")
                    .font(Font.body.bold())
                    .frame(maxWidth: .infinity, alignment:.leading)
                    .padding()
                
                ForEach(0..<list.count, id: \.self) { index in
                    VStack {
                        if index == 0 { Divider() }
                        AlarmCell(alarmData: list[index])
                        Divider()
                    }
                }
            }
            .navigationBarTitle("Alarme")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Editar") {
                        print("Editar pressed")
                    }.foregroundColor(.orange)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingSheet.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .foregroundColor(.orange)
                    .sheet(isPresented: $showingSheet) {
                        NavigationView {
                            GeometryReader { geometry in
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
                                                TextField("Alarme", text: $alarme)
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
                            }
                            .navigationBarItems(leading: Button ("Cancelar", action: {showingSheet = false}))
                            .navigationTitle("Adicionar Alarme").navigationBarTitleDisplayMode(.inline)
                            .navigationBarItems(trailing: Button (action: {
                                addElement()
                                
                            }, label: Text("Salvar").bold))
                            .accentColor(.orange)
                        }
                        
                    }
                }
                
            }
            
        }
        
    }
}


struct AlarmeView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmeView()
    }
}

