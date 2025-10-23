//
//  CookingRecipe.swift
//  CookingRecipe
//
//  Created by Jacob Wheeler on 10/3/25.
//

import SwiftUI

@main
struct CookingRecipeApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                
                .environment(\.colorScheme, isDarkMode ? .dark : .light)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}



