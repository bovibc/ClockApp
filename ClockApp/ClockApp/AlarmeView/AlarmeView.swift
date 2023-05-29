//
//  AlarmeView.swift
//  ClockApp
//
//  Created by Pamella Alvarenga on 23/05/23.
//

import SwiftUI

struct AlarmeView: View {
//    @State private var editar = false
//    let image = UIImage(systemName: "bed.double.fill")
    
    let bedImage = UIImage(systemName: "bed.double.fill.mine")
    @State private var showingSheet = false
    
    var body: some View {
        
        NavigationView {
            ScrollView{
                
                Label("Dormir|Acordar", systemImage: "bed.double.fill")
                    .font(Font.body.bold())
                    .frame(maxWidth: .infinity, alignment:.leading)
                    .padding()
                
            }
            .navigationBarTitle("Alarme")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Editar") {
                        print("Editar pressed")
                    }
                }
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("+") {
                        showingSheet.toggle()
                    }
                    .sheet(isPresented: $showingSheet) {
                        NavigationView {
                            AdicionarAlarme()
                                .navigationBarItems(leading: Button ("Cancelar", action:{}))
                                .navigationTitle("Adicionar Alarme").navigationBarTitleDisplayMode(.inline)
                                .navigationBarItems(trailing: Button (action: {
                                    print("")
                                }, label: Text("Salvar").bold))
                        }.accentColor(.orange)
                    }
                    
                    
                    
                }
                
            }
            
        }
        .accentColor(.orange)
        
        
    }
}

struct AlarmeView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmeView()
    }
}

