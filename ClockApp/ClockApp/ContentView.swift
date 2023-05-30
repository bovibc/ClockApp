//
//  ContentView.swift
//  ClockApp
//
//  Created by Bruna Lacerda on 24/05/23.
//


// tab bar

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            
            Relogio()
                .tabItem{
                    Image(systemName: "globe")
                    Text("Relógio")
                }
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

