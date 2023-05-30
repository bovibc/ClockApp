//
//  teste.swift
//  ClockApp
//
//  Created by Bruna Lacerda on 30/05/23.
//

import SwiftUI

struct teste: View {
    @State private var users = ["Paul", "Lucas", "Maria"]
    var body: some View {
        NavigationStack {
            List {
                ForEach(users, id: \.self) { user in
                    Text(user)
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
            }.toolbar {
                EditButton()
                    .navigationTitle("Users")
            }
        }
    }
        func delete(at offsets: IndexSet) {
            users.remove(atOffsets: offsets)
        }
        func move(from source: IndexSet, to destination: Int) {
            users.move(fromOffsets: source, toOffset: destination)
        }
    }

        
struct teste_Previews: PreviewProvider {
    static var previews: some View {
        teste()
    }
}
