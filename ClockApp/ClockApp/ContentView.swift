//
//  ContentView.swift
//  ClockApp
//
//  Created by Clissia Bozzer Bovi on 22/05/23.
//

import SwiftUI

struct StopwatchView: View {
    @State private var progressTime = 0
    @State private var isRunning = false
    @State private var timer: Timer?
    @State private var laps: [Int] = []
    @State private var lapButtonEnabled = false
    @State private var showResetButton = false
    
    var hours: Int {
        progressTime / 3600
    }
    
    var minutes: Int {
        (progressTime % 3600) / 60
    }
    
    var seconds: Int {
        progressTime % 60
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 3) {
                StopwatchUnit(timeUnit: hours)
                Text(":")
                    .font(.system(size: 70))
                    .offset(y: -5)
                StopwatchUnit(timeUnit: minutes)
                Text(",")
                    .font(.system(size: 70))
                    .offset(y: -5)
                StopwatchUnit(timeUnit: seconds)
            }
            
            HStack {
                if showResetButton {
                    Button(action: {
                        resetLaps()
                        lapButtonEnabled = false
                    }) {
                        ZStack {
                            Circle()
                                .frame(width: 120, height: 90, alignment: .center)
                                .foregroundColor(.gray)
                            Circle()
                                .frame(width: 120, height: 85, alignment: .center)
                                .foregroundColor(.black)
                            Circle()
                                .frame(width: 120, height: 80, alignment: .center)
                                .foregroundColor(.gray)
                            Text("Reset")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                    }
                } else {
                    Button(action: {
                        lap()
                    }) {
                        ZStack {
                            Circle()
                                .frame(width: 120, height: 90, alignment: .center)
                                .foregroundColor(.gray)
                            Circle()
                                .frame(width: 120, height: 85, alignment: .center)
                                .foregroundColor(.black)
                            Circle()
                                .frame(width: 120, height: 80, alignment: .center)
                                .foregroundColor(.gray)
                            Text("Lap")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                    }
                    .disabled(!lapButtonEnabled)
                }
                
                Spacer()
                
                Button(action: {
                    toggleStopwatch()
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 120, height: 90, alignment: .center)
                            .foregroundColor(isRunning ? .red : .green)
                        Circle()
                            .frame(width: 120, height: 85, alignment: .center)
                            .foregroundColor(.black)
                        Circle()
                            .frame(width: 120, height: 80, alignment: .center)
                            .foregroundColor(isRunning ? .red : .green)
                        Text(buttonText)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
            }
            
            if laps.count > 0 {
                Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 10)
                
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(laps.indices, id: \.self) { index in
                        HStack {
                            Text("Lap \(index + 1):")
                            Spacer()
                            Text(formattedTime(laps[index]))
                        }
                        .padding(.horizontal, 10)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 10)
                    }
                }
                .padding(.top, 10)
            }
        }
    }

            var buttonText: String {
                if progressTime == 0 {
                    return "Start"
                } else {
                    return isRunning ? "Stop" : "Start"
                }
            }
            
            func toggleStopwatch() {
                if isRunning {
                    stopTimer()
                    if progressTime == 0 {
                        lapButtonEnabled = false
                    } else {
                        showResetButton = true
                    }
                } else {
                    if progressTime == 0 {
                        laps.removeAll()
                        lapButtonEnabled = false
                        showResetButton = false
                    }
                    startTimer()
                    lapButtonEnabled = true
                    showResetButton = false
                }
                
                isRunning.toggle()
            }
            
            func startTimer() {
                timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                    progressTime += 1
                }
            }
            
            func stopTimer() {
                timer?.invalidate()
                timer = nil
            }
            
            func resetLaps() {
                stopTimer()
                progressTime = 0
                laps.removeAll()
                lapButtonEnabled = false
                showResetButton = false
            }
            
            func lap() {
                laps.append(progressTime)
            }
            
            func formattedTime(_ time: Int) -> String {
                let seconds = time % 60
                let minutes = (time / 60)
                
                let formattedSeconds = seconds < 10 ? "0\(seconds)" : "\(seconds)"
                let formattedMinutes = minutes < 10 ? "0\(minutes)" : "\(minutes)"
                
                return "\(formattedMinutes):\(formattedSeconds)"
            }
        }
        
        struct StopwatchUnit: View {
            var timeUnit: Int
            var timeUnitStr: String {
                let timeUnitStr = String(timeUnit)
                return timeUnit < 10 ? "0" + timeUnitStr : timeUnitStr
            }
            
            var body: some View {
                VStack {
                    ZStack {
                        HStack(spacing: -5) {
                            Text(timeUnitStr.substring(index: 0))
                                .font(.system(size: 70))
                                .frame(width: 50)
                            Text(timeUnitStr.substring(index: 1))
                                .font(.system(size: 70))
                                .frame(width: 50)
                        }
                    }
                }
            }
        }
        
        struct Stopwatch_Previews: PreviewProvider {
            static var previews: some View {
                StopwatchView()
            }
        }
        
        extension String {
            func substring(index: Int) -> String {
                let arrayString = Array(self)
                return String(arrayString[index])
            }
        }
