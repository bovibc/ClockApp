//
//  SwiftUIView.swift
//  ClockApp
//
//  Created by Pamella Alvarenga on 26/05/23.
//

import SwiftUI

struct DiasDaSemana: View {
    @Environment (\.dismiss) var dismiss
    @State var todo_domingo: Bool = false
    @State var toda_segunda_feira: Bool = false
    @State var toda_terca_feira: Bool = false
    @State var toda_quarta_feira: Bool = false
    @State var toda_quinta_feira: Bool = false
    @State var toda_sexta_feira: Bool = false
    @State var todo_sabado: Bool = false
    
    var body: some View {
        List{
           // Toggle("Todo domingo", isOn: $segunda_feira)
               // .toggleStyle(.)
          
            Toggle("Todo domingo", isOn: $todo_domingo).toggleStyle(OrangeCheckToggleStyle())
            Toggle("Toda segunda-feira", isOn: $toda_segunda_feira).toggleStyle(OrangeCheckToggleStyle())
            Toggle("Toda terca-feira", isOn: $toda_terca_feira).toggleStyle(OrangeCheckToggleStyle())
            Toggle("Toda quarta-feira", isOn: $toda_quarta_feira).toggleStyle(OrangeCheckToggleStyle())
            Toggle("Toda quinta-feira", isOn: $toda_quinta_feira).toggleStyle(OrangeCheckToggleStyle())
            Toggle("Toda sexta-feira", isOn: $toda_sexta_feira).toggleStyle(OrangeCheckToggleStyle())
            Toggle("Todo sabado", isOn: $todo_sabado).toggleStyle(OrangeCheckToggleStyle())
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Voltar")
                    }
                }
            }
        }.navigationTitle("Repetir")
        .navigationBarBackButtonHidden(true)
    }
}

struct OrangeCheckToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            configuration.label
            Button{
                configuration.isOn.toggle()
            } label: {
                HStack{
                    Spacer()
                    Image(systemName: configuration.isOn ? "checkmark":  "")
                        
                }
                }.accentColor(.orange)
                .bold()
        }
    }
}

struct DiasDaSemana_Previews: PreviewProvider {
    static var previews: some View {
        DiasDaSemana()
    }
}

//Today:

//loop ddos numeros pagina anterior



