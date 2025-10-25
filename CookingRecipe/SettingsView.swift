//
//  SettingsView.swift
//  CookingRecipe
//
//  Created by Jacob Wheeler on 10/13/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isGestureControlEnabled") private var isGestureControlEnabled = false 
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                Toggle(isOn: $isDarkMode) {
                    Label("Dark Mode", systemImage: "moon.fill")
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))
            }
            
            Section(header: Text("Hands-Free Mode")) {
                Toggle(isOn: $isGestureControlEnabled) {
                    Label("Camera Gesture Control", systemImage: "hand.wave.fill")
                }
                .toggleStyle(SwitchToggleStyle(tint: .green))
                
                Text(isGestureControlEnabled
                     ? "Front camera is used to detect hand gestures for scrolling."
                     : "Gesture control is disabled.")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Settings")
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    SettingsView()
}

