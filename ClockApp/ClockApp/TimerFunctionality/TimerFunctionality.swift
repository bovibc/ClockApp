//
//  TimerFunctionality.swift
//  ClockApp
//
//  Created by Clissia Bozzer Bovi on 23/05/23.
//

import SwiftUI

struct TimerFunctionality: View {

    //MARK: - Properties
    @State private var hours: Int = 0
    @State private var isTimerRunning: Bool = false
    @State private var showingSheet = false
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    @State private var timeInSeconds: Int = 0
    @State private var timeLeft: Int = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var cancelButtonColor: Color {
            return !isTimerRunning ? .gray : .white
    }
    
    private var initButtonColor: Color {
            return isTimerRunning ? .gray : .white
    }
    
    //MARK: - Timer Functions
    private func startTimer() {
        getTime()
        isTimerRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    private func cancelTimer() {
        isTimerRunning = false
        self.timer.upstream.connect().cancel()
    }
    
    private func getTime() {
        timeInSeconds = seconds + 60 * minutes + 3600 * hours
        timeLeft = timeInSeconds
    }
    
    private func shouldShowTime() -> Bool {
        return isTimerRunning && (timeInSeconds != 0)
    }
    
    //MARK: - UI
    private func getPicker() -> some View {
        return HStack {
            Picker("Timer", selection: $hours) {
                ForEach((0...23), id: \.self) {
                    Text("\($0)")
                }
            } .pickerStyle(.wheel)
            Text("**horas**")
            
            Picker("Timer", selection: $minutes) {
                ForEach((0...59), id: \.self) {
                    Text("\($0)")
                }
            } .pickerStyle(.wheel)
            Text("**min**")
            
            Picker("Timer", selection: $seconds) {
                ForEach((0...59), id: \.self) {
                    Text("\($0)")
                }
                
            } .pickerStyle(.wheel)
            Text("**s**")
        }
    }
    
    private func getCancelButton() -> some View {
        return Button {
            cancelTimer()
        } label: {
            Text("cancelar")
                .frame(width: 80, height: 80)
                .foregroundColor(cancelButtonColor)
                .background(Color.gray)
                .opacity(0.8)
                .clipShape(Circle())
        }
    }
    
    private func getInitButton() -> some View {
        return Button {
            getTime()
            if timeInSeconds != 0 {
                startTimer()
            }
        } label: {
            Text("Iniciar")
                .frame(width: 80, height: 80)
                .foregroundColor(initButtonColor)
                .background(Color.green)
                .clipShape(Circle())
        }
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    if shouldShowTime() {
                        ZStack {
                            CircularProgress(timeInSeconds: timeInSeconds, pastTime: 0, shouldShowTime: false, lineWidth: 8)
                            CircularProgress(timeInSeconds: timeInSeconds, pastTime: timeLeft, shouldShowTime: true, lineWidth: 8, color: .yellow)
                                .onReceive(timer, perform: { _ in
                                    timeLeft -= 1
                                    if timeLeft == 0 {
                                        self.cancelTimer()
                                    }
                                })
                        }
                    } else {
                        getPicker()
                    }
                }
                .frame(width: 280, height: 280, alignment: .center)
                .padding(.all, 8)
                
                HStack {
                    getCancelButton()
                        .disabled(!isTimerRunning)
                    
                    Spacer()
                    
                    getInitButton()
                        .disabled(isTimerRunning)
                    
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 64)
                
                Button {
                    showingSheet.toggle()
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.secondary)
                            .opacity(0.4)
                            .cornerRadius(8)
                            .frame(height: 48)
                        HStack {
                            Text("Ao terminar")
                                .foregroundColor(.white)
                            Spacer()
                            Text("Radar")
                                .foregroundColor(.gray)
                            Image(systemName: "arrow.right")
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                    }
                }
                .sheet(isPresented: $showingSheet) {
                    NavigationView {
                        SongSheet()
                            .navigationBarItems(trailing: Button(action: {
                                print("")
                            }, label: Text("Definir").bold))
                            .navigationBarItems(leading: Button("Cancelar", action: {}))
                            .navigationTitle("Ao Terminar").navigationBarTitleDisplayMode(.inline)
                            
                    }
                    
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 32)
            }
            .padding(.top, 16)
        }
    }
}

struct Timer_Previews: PreviewProvider {
    static var previews: some View {
        TimerFunctionality()
    }
}
