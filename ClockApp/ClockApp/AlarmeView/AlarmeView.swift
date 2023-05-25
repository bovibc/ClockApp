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
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("+") {
                            print("+ pressed")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading){
                        Button("Editar") {
                            print("Editar pressed")
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
