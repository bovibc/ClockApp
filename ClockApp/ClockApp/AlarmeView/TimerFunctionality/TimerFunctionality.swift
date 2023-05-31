//
//  TimerFunctionality.swift
//  ClockApp
//
//  Created by Clissia Bozzer Bovi on 23/05/23.
//

import SwiftUI

struct TimerFunctionality: View {

    //MARK: - Properties
    @State private var presentAlert = false
    @State private var hours: Int = 0
    @State private var isTimerRunning: Bool = false
    @State private var isTimerPaused: Bool = false
    @State private var showingSheet = false
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    @State private var timeInSeconds: Int = 0
    @State private var timeLeft: Int = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var progressColor: Color = Color(uiColor: UIColor(red: 241/255, green: 164/255, blue: 60/255, alpha: 1))

    //MARK: - Timer Functions
    private func startTimer() {
        getTime()
        if timeInSeconds == 0 { return }
        isTimerRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }

    private func cancelTimer() {
        isTimerRunning = false
        isTimerPaused = false
        self.timer.upstream.connect().cancel()
    }

    private func pauseTimer() {
        isTimerPaused = true
        self.timer.upstream.connect().cancel()
    }

    private func resumeTimer() {
        isTimerPaused = false
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
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
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    if shouldShowTime() {
                        ZStack {
                            CircularProgress(timeInSeconds: timeInSeconds, pastTime: 0, shouldShowTime: false, lineWidth: 8)
                            CircularProgress(timeInSeconds: timeInSeconds, pastTime: timeLeft, shouldShowTime: true, lineWidth: 8, color: progressColor)
                                .onReceive(timer, perform: { _ in
                                    timeLeft -= 1
                                    if timeLeft == 0 {
                                        self.cancelTimer()
                                        presentAlert = true
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
                    GenericButton(type: .cancel,isTimerRunning: isTimerRunning ,action: cancelTimer)
                        .disabled(!isTimerRunning)

                    Spacer()

                    if isTimerRunning {
                        if isTimerPaused {
                            GenericButton(type: .resume, action: resumeTimer)
                        } else {
                            GenericButton(type: .pause, action: pauseTimer)
                        }
                    } else {
                        GenericButton(type: .initiate, action: startTimer)
                    }
                    
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 8)

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
            .alert("Alerta", isPresented: $presentAlert, actions: {
                Button("Ok", role: .cancel, action: {})
            })
            .padding(.top, 16)
        }
    }
}

struct Timer_Previews: PreviewProvider {
    static var previews: some View {
        TimerFunctionality()
    }
}
