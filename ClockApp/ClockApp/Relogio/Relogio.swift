//
//  Relógio.swift
//  ClockApp
//
//  Created by Bruna Lacerda on 24/05/23.
//


/*add as linhas q separa - list nao ta funcionando
 deve ter um jeito mais facil que:
Path() { path in
      path.move(to: CGPoint( x:20, y:20)}
 .stroke(Color.gray, linewidth: 10) */


import SwiftUI


struct Relogio: View {
    
    @State var showSheet : Bool = false
    @Environment(\.presentationMode) var presentationMode
    //@ObservedObject var taskStore = TaskStore()
    
    var body: some View {
        NavigationView {
//            List {
//                VStack {
//                    ScrollView(){
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
//
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
//
//
//                    } .padding(.leading)
//                        .padding(.trailing)
         //   }
            VStack {
                ScrollView(){
                    VStack {
                        Text("Hoje, +0h")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.gray)
                            .font(.system(size: 20))

                        HStack {
                            Text("São Paulo")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 28))
                            Text("9:31")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .font(.system(size: 40))
                        }
                    }

                    Divider()


                } .padding(.leading)
                    .padding(.trailing)
                    
                
            }
            .navigationBarTitle("Relógio")
             .navigationBarItems(leading: EditButton())
//             .onMove(perform: self.move)
//             .onDelete(perform: self.delete)
            // no final da list
                
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
                    ListTimeZone()
//                        .navigationBarItems(trailing: Button("Cancelar", action:{
//                            presentationMode.wrappedValue.dismiss()
//                        }).foregroundColor(.orange))
                        
                            .navigationTitle("Escolha uma cidade").navigationBarTitleDisplayMode(.inline)
                }
                
                
            }
        }
        .accentColor(.orange)
    }
//        func move (from source: IndexSet, to destination: Int){
//            taskStore.tasks.move(fromOffsets: source, toOffset: destination)
//        }
//
//        func delete (at offsets :IndexSet){
//            taskStore.tasks.remove(atOffsets: offsets)
//        }
    
    
}

struct Relogio_Previews: PreviewProvider {
    static var previews: some View {
        Relogio()
    }
}


//list em baixo do nav view
