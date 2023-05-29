//
//  ListTimeZone.swift
//  ClockApp
//
//  Created by Bruna Lacerda on 25/05/23.
//

// search bar e cancelar em HStack
//categorias na lista
//filtro de ordem alfabética

import SwiftUI

struct ListTimeZone: View {
    
    @Environment(\.presentationMode) var presentationMode
    private var ListTimeZone = cities
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(citiess, id: \.self) { city in
                    HStack{
                        Text(city.capitalized)
                    }
                }
            }.searchable(text: $searchText)
            
        }.navigationBarItems(trailing: Button("Cancelar", action:{presentationMode.wrappedValue.dismiss()
        }).foregroundColor(.orange))
    }
    
    var citiess: [String] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter {$0.localizedCaseInsensitiveContains(searchText)}
        }
    }
}
            

struct ListTimeZone_Previews: PreviewProvider {
    static var previews: some View {
        ListTimeZone()
    }
}
