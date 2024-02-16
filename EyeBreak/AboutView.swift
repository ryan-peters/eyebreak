//
//  AboutView.swift
//  EyeBreak
//
//  Created by Ryan Peters on 2/5/24.
//

import SwiftUI

struct AboutView: View {
    
    var version: String {
        (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) ?? "Unknown"
    }
    
    var body: some View {
        ScrollView {
            Text("EyeBreak")
                .padding(.top, 10)
                .font(.title)
                .fontWeight(.bold)
            Text("Version \(version)")
                .font(.subheadline)
            Divider()
            VStack (alignment: .leading){
                
                VStack(alignment: .leading) {
                    Text("How to Use")
                        .fontWeight(.bold)
                    Text("EyeBreak leverages the 20/20/20 rule to combat eye strain, prompting you every 20 minutes to look at something 20 feet away for at least 20 seconds. This practice is essential for maintaining your eye health during extended periods of screen time. EyeBreak ensures that these reminders are delivered as discreet notifications, designed to minimize disruption and preserve your focus. Additionally, the app smartly pauses the timer when you're not actively using your computer, ensuring breaks are prompted based on actual screen time.")
                        .padding(.bottom)
                        Text("Customizing Your Experience")
                            .fontWeight(.bold)
                        Text("Understanding that everyone's work habits are unique, EyeBreak allows you to personalize the reminder intervals. Head over to the settings to adjust the work and break durations to fit your personal preference and workflow. This flexibility ensures that EyeBreak supports your productivity in the healthiest manner possible.")
                }
                Divider()
                VStack(alignment: .leading) {
                    Text("Credits")
                        .fontWeight(.bold)
                    Text("Developed by Ryan Peters")
                }
                Divider()
                VStack(alignment: .leading) {
                    Text("License")
                        .fontWeight(.bold)
                    Text("This application is open-source, licensed under the MIT License. For more details, visit my GitHub repository.")
                }
                Link("GitHub Repository", destination: URL(string: "https://github.com/ryan-peters")!)
                Divider()
                VStack(alignment: .leading) {
                    Text("Privacy Policy")
                        .fontWeight(.bold)
                    Text("EyeBreak does not collect or store any personal information.")
                }
            }
            .padding()
        }
    }
    
}

#Preview {
    AboutView()
}
