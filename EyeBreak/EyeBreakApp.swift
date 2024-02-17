//
//  EyeBreakApp.swift
//  EyeBreak
//
//  Created by Ryan Peters on 2/3/24.
//

import SwiftUI
import UserNotifications

@main
struct EyeBreakApp: App {
    
    @StateObject private var settings = Settings()
    @StateObject var timerViewModel: TimerViewModel
    @State private var showingAboutWindow = false
    
    init() {
        _timerViewModel = StateObject(wrappedValue: TimerViewModel())
        
    }
    var body: some Scene {
        
        MenuBarExtra() {
            Text(timerViewModel.timeLabel)
            Button(timerViewModel.isRunning ? "Pause Clock" : "Start Clock") {
                timerViewModel.isRunning ? timerViewModel.pauseTimer() : timerViewModel.resumeTimer()
            }
            Divider()
            Button("Settings") {
                let settingsWindowController = SettingsWindowController()
                settingsWindowController.showWindow()
            }
            Divider()
            Button("About EyeBreak") {
                let aboutWindowController = AboutWindowController()
                aboutWindowController.showWindow()
            }
            Button("Quit EyeBreak") {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                NSApplication.shared.terminate(nil)
            }
        } label: {
            HStack {
                Image(systemName: "eyes")
                if (timerViewModel.isOnBreak) {
                    Text(" Look away now")
                }
            }
        }
    }
}
