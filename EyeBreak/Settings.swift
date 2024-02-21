//
//  Settings.swift
//  EyeBreak
//
//  Created by Ryan Peters on 2/6/24.
//

import Foundation
import AppKit

class Settings: ObservableObject {
    @Published var intervalTime: Double {
        didSet {
            UserDefaults.standard.set(intervalTime, forKey: "intervalTime")
        }
    }
    @Published var breakTime: Double {
        didSet {
            UserDefaults.standard.set(breakTime, forKey: "breakTime")
        }
    }
    @Published var showDockIcon: Bool {
        didSet {
            UserDefaults.standard.set(showDockIcon, forKey: "showDockIcon")
            updateDockIconVisibility(show: showDockIcon)
        }
    }
    @Published var showBreakOverNotification: Bool {
        didSet {
            UserDefaults.standard.set(showBreakOverNotification,  forKey: "showBreakOverNotification")
        }
    }
    
    init() {
        self.intervalTime = UserDefaults.standard.double(forKey: "intervalTime")
        self.breakTime = UserDefaults.standard.double(forKey: "breakTime")
        self.showDockIcon = UserDefaults.standard.bool(forKey: "showDockIcon")
        self.showBreakOverNotification = UserDefaults.standard.bool(forKey: "showBreakOverNotification")
        
        if self.intervalTime == 0 { self.intervalTime = 1200 }
        if self.breakTime == 0 { self.breakTime = 20 }
        
        updateDockIconVisibility(show: showDockIcon)
        
    }
    
    private func updateDockIconVisibility(show: Bool) {
        DispatchQueue.main.async {
            if show {
                NSApp.setActivationPolicy(.regular)
            } else {
                NSApp.setActivationPolicy(.accessory)
            }
        }
    }
}
