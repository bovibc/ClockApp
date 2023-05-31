//
//  Stopwatch.swift
//  ClockApp
//
//  Created by Pamella Alvarenga on 24/05/23.
//

import SwiftUI

struct Stopwatch: View {
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
    
    private func resetAction() {
        resetLaps()
        lapButtonEnabled = false
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
            .padding(.bottom, 100)
            
            HStack {
                if showResetButton {
                    GenericButton(type: .reset, action: resetAction)
                    
                } else {
                    GenericButton(type: .lap, action: lap)
                    .disabled(!lapButtonEnabled)
                }
                
                Spacer()
                
                GenericButton(type: ((isRunning) ? .stop : .initiate), action: toggleStopwatch)
            }
            
            Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 10)
            
            if laps.count > 0 {
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(laps.indices, id: \.self) { index in
                        HStack {
                            Text("Volta \(index + 1):")
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
            return "Iniciar"
        } else {
            return isRunning ? "Parar" : "Iniciar"
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
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
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
        let hours = time / 3600
        
        let formattedSeconds = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        let formattedMinutes = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let formattedHours = hours < 10 ? "0\(hours)" : "\(hours)"
        
        return "\(formattedHours):\(formattedMinutes):\(formattedSeconds)"
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
        Stopwatch()
    }
}

extension String {
    func substring(index: Int) -> String {
        let arrayString = Array(self)
        return String(arrayString[index])
    }
}
