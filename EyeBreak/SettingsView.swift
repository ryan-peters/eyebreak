//
//  SettingsView.swift
//  EyeBreak
//
//  Created by Ryan Peters on 2/6/24.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var settings: Settings
    @State private var tempIntervalTime: Double
    @State private var tempBreakTime: Double
    @State private var tempShowDockIcon: Bool
    
    init(settings: Settings) {
        self.settings = settings
        _tempIntervalTime = State(initialValue: settings.intervalTime)
        _tempBreakTime = State(initialValue: settings.breakTime)
        _tempShowDockIcon = State(initialValue: settings.showDockIcon)
        
    }
    
    var body: some View {
        ScrollView {
            Text("EyeBreak Settings")
                .padding(.top, 10)
                .font(.title)
                .fontWeight(.bold)
            Divider()
            HStack{
                VStack {
                    Text("Working Time: \(Int((tempIntervalTime/60).rounded())) minutes")
                    Slider(value: $tempIntervalTime, in: 120...3600)
                        .padding()
                }
                VStack {
                    Text("Break Time: \(Int((tempBreakTime).rounded())) seconds")
                    Slider(value: $tempBreakTime, in: 10...60)
                        .padding()
                }
                
            }
            VStack{
                Toggle(isOn: $tempShowDockIcon) {
                    Text("Show App Icon in Dock")
                }.padding()
                
            }
            HStack{
                Button("Reset") {
                    tempIntervalTime = settings.intervalTime
                    tempBreakTime = settings.breakTime
                    tempShowDockIcon = settings.showDockIcon
                }
                Button("Save"){
                    settings.intervalTime = tempIntervalTime
                    settings.breakTime = tempBreakTime
                    settings.showDockIcon = tempShowDockIcon
                    
                    closeWindow()
                }.padding()
            }
            
        }
    }
    
    private func closeWindow() {
        if let window = NSApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            window.close()
        }
    }
    
}



#Preview {
    SettingsView(settings: Settings())
}
