//
//  ViewModel.swift
//  ClockApp
//
//  Created by Ana Elisa Lima on 31/05/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var presenters: [LapItemInspector] = []
    @Published var currentLapTime: String = ""
    @Published var isLapStarted: Bool = false
    @Published var lapTimes: [Double] = []
    private var lapIndex: Int = 0
    private var startDate: Date?
    private var timer: Timer?
    
    init() {
        self.presenters = []
        self.lapTimes.append(0)
        self.currentLapTime = self.getFormattedString(_timeElapsed: 0)
    }
    
    func rightButtonTapped() {
        if self.isLapStarted {
            self.lapTimes[self.lapIndex] += self.getTimeElapsed()
            self.timer?.invalidate()
        } else {
            self.startDate = Date()
            self.updatePresenters()
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [weak self] (_) in
                self?.updateCurrentLapTime()
            })
        }
        self.isLapStarted.toggle()
    }
    
    func leftButtonTapped() {
        if self.isLapStarted {
            self.lapTimes[self.lapIndex] = 0
              self.updateCurrentLapTime()
            
          } else {
              self.lapTimes = [0]
              self.presenters = []
              self.currentLapTime = self.getFormattedString(_timeElapsed: 0)
              self.lapIndex = 0
          }
      }
    
    private func updateCurrentLapTime() {
        var timeElapsed: TimeInterval = 0
        if startDate != nil {
            timeElapsed = self.getTimeElapsed()
        }
        timeElapsed += self.lapTimes[self.lapIndex]
        
        self.currentLapTime = self.getFormattedString(_timeElapsed: timeElapsed)
        self.presenters[self.lapIndex].time = self.currentLapTime
    }
    
    private func getTimeElapsed() -> Double {
        return Date().timeIntervalSince1970 - self.startDate!.timeIntervalSince1970
    }
    
    private func getFormattedString(_timeElapsed: Double) -> String {
        var timeElapsed = _timeElapsed
        
        let minutes: Int = Int(timeElapsed / 60)
        timeElapsed -= (Double(minutes) * 60)
        
        let seconds: Int = Int(timeElapsed)
        timeElapsed -= Double(seconds)
        
        let milliseconds = Int(timeElapsed * 100)
        
        return String(format: "%02d:%02d,%02d", minutes, seconds, milliseconds)
    }
    
    private func updatePresenters() {
        self.presenters = []
        for (index, lap) in self.lapTimes.enumerated() {
            self.presenters.append(LapItemInspector(lap: "Lap \(index + 1)", time: self.getFormattedString(_timeElapsed: lap), type: .normal))
        }
    }
}

