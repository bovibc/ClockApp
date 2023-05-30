//
//  Relógio.swift
//  ClockApp
//
//  Created by Bruna Lacerda on 24/05/23.
//

import SwiftUI
import Combine


struct Relogio: View {
    
    @State var showSheet : Bool = false
    @State private var ListTimeZone = cities
    //@ObservedObject var cityStore = CityStore()
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(/*self.cityStore.city*/ ListTimeZone, id: \.self) { city in
                    VStack {
                        Text("Hoje, +0h")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.gray)
                            .font(.system(size: 20))
                        
                        HStack {
                            Text(city)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 28))
                            Text("9:31")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .font(.system(size: 40))
                        }
                    }
                    
                    
                    
                    //                ForEach(ListTimeZone, id: \.self) { list in
                    //                    Text(list)
                }.onMove { indexSet, offset in
                    ListTimeZone.move(fromOffsets: indexSet, toOffset: offset)
                    
                }
                //.onMove(perform: move)
                .onDelete(perform: delete)
                //.listRowBackground(Color.black)
                // .onDelete(perform: delete)
                
                
                //                VStack {
                //                    //ScrollView(){
                //                        VStack {
                //                            Text("Hoje, +0h")
                //                                .frame(maxWidth: .infinity, alignment: .leading)
                //                                .foregroundColor(.gray)
                //                                .font(.system(size: 20))
                //
                //                            HStack {
                //                                Text("São Paulo")
                //                                    .frame(maxWidth: .infinity, alignment: .leading)
                //                                    .font(.system(size: 28))
                //                                Text("9:31")
                //                                    .frame(maxWidth: .infinity, alignment: .trailing)
                //                                    .font(.system(size: 40))
                //                            }
                //                        }
                //
                //                        Divider()
                // .padding(.vertical)
                
                //                        VStack {
                //                            Text("Hoje, +0h")
                //                                .frame(maxWidth: .infinity, alignment: .leading)
                //                                .foregroundColor(.gray)
                //                                .font(.system(size: 20))
                //
                //                            HStack {
                //                                Text("Brasília")
                //                                    .frame(maxWidth: .infinity, alignment: .leading)
                //                                    .font(.system(size: 28))
                //                                Text("9:31")
                //                                    .frame(maxWidth: .infinity, alignment: .trailing)
                //                                    .font(.system(size: 40))
                //                            }
                //                        }
                
                
                // }
                //}
            }
            .navigationBarTitle("Relógio")
            .navigationBarItems(leading: EditButton())
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSheet.toggle()
                    } , label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .sheet(isPresented: $showSheet) {
                NavigationView {
                    ClockApp.ListTimeZone()
                        .navigationTitle("Escolha uma cidade").navigationBarTitleDisplayMode(.inline)
                }
                
                
            }
        }
        .accentColor(.orange)
    }
    
    
    func delete(at offsets: IndexSet) {
        ListTimeZone.remove(atOffsets: offsets)
    }
    func move(from source: IndexSet, to destination: Int) {
        ListTimeZone.move(fromOffsets: source, toOffset: destination)
    }
}



struct Relogio_Previews: PreviewProvider {
    static var previews: some View {
        Relogio()
    }
}


