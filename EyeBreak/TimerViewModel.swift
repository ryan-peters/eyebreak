//
//  TimerViewModel.swift
//  EyeBreak
//
//  Created by Ryan Peters on 2/3/24.
//

import Foundation
import UserNotifications
import IOKit.hid

class TimerViewModel: ObservableObject {
    
    @Published var currentTime: String = "Starting..."
    @Published var isRunning: Bool = false
    @Published var isOnBreak: Bool = false
    
    @Published var intervalTime: Double
    @Published var breakTime: Double
    private var settings = Settings()
    var breakTimer: TimeInterval = 20
    var countdownRemaining: TimeInterval
    var timer: Timer?
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Notification permission granted.")
            }
        }
        
        self.intervalTime = self.settings.intervalTime
        self.breakTime = self.settings.breakTime
        self.countdownRemaining = self.settings.intervalTime
        
        startTimer()
    }
    
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.tick()
        }
        isRunning = true
        isOnBreak = false
    }
    
    func tick() {
        if countdownRemaining > 0 {
            if getIdleTime() < 10 {
                countdownRemaining -= 1
                currentTime = TimerViewModel.formatTime(countdownRemaining)
            }
        } else {
            timer?.invalidate()
            timer = nil
            
            isOnBreak = true
            currentTime = "Look away now..."
            resetTimer()
            scheduleNotification()
        }
    }
    
    func pauseTimer() {
        isRunning = false
        timer?.invalidate()
    }
    
    func resumeTimer() {
        startTimer()
    }
    
    func resetTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + self.breakTime) { [weak self] in
            guard let self = self else { return }
            self.countdownRemaining = self.intervalTime
            self.resumeTimer()
        }
    }
    
    static func formatTime(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60 + 1
        let label = minutes > 1 ? "minutes" : "minute"
        
        return String(format: "\(minutes) \(label)" )
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Eye Break"
        content.body = "Look away from the screen for 20 seconds"
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
    
    func getIdleTime() -> TimeInterval {
        var idleTime = TimeInterval(0)
        let service = IOServiceGetMatchingService(kIOMainPortDefault, IOServiceMatching("IOHIDSystem"))
        
        if service != 0 {
            var unmanagedDict: Unmanaged<CFMutableDictionary>?
            if IORegistryEntryCreateCFProperties(service, &unmanagedDict, kCFAllocatorDefault, 0) == KERN_SUCCESS {
                if let dict = unmanagedDict?.takeRetainedValue() {
                    let key: CFString = "HIDIdleTime" as CFString
                    let value = CFDictionaryGetValue(dict, Unmanaged.passUnretained(key).toOpaque())
                    if let value = value {
                        let number = Unmanaged<CFNumber>.fromOpaque(value).takeUnretainedValue()
                        var nanoseconds: Int64 = 0
                        if CFNumberGetValue(number, CFNumberType.sInt64Type, &nanoseconds) {
                            idleTime = TimeInterval(nanoseconds) / 1_000_000_000
                        }
                    }
                }
            }
            IOObjectRelease(service)
        }
        
        return idleTime
    }
    
}
