//
//  ContentView.swift
//  ClockApp
//
//  Created by Clissia Bozzer Bovi on 22/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            
            AlarmeView()
                .tabItem{
                    Image(systemName: "alarm.fill")
                    Text("Alarme")
                }
            Stopwatch()
                .tabItem{
                    Image(systemName: "stopwatch.fill")
                    Text("Cronômetro")
                }
            TimerFunctionality()
                .tabItem{
                    Image(systemName: "timer")
                    Text("Timer")
                }
        }
        .accentColor(.orange)
        .onAppear() {
            UITabBar.appearance().backgroundColor = .systemGray6
        }
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

