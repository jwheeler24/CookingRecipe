//
//  ContentView.swift
//  CookingRecipe
//
//  Created by Jacob Wheeler on 10/3/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.3), Color.red.opacity(0.3)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Text("🍽 Recipes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 40)
                    
                    // Category card
                    NavigationLink(destination: CategoryListView()) {
                        HomeCardView(title: "Browse by Category", emoji: "🥩", color: .pink)
                    }
                    
                    // Area card
                    NavigationLink(destination: AreaListView()) {
                        HomeCardView(title: "Browse by Area", emoji: "🌍", color: .blue)
                    }
                    
                    // Ingredient card
                    NavigationLink(destination: IngredientListView()) {
                        HomeCardView(title: "Browse by Ingredient", emoji: "🥕", color: .green)
                    }
                    
                    NavigationLink(destination: SettingsView()) {
                        HomeCardView(title: "Settings", emoji: "⛭", color: .gray)
                    }
                    
                    Spacer()
                
                    Text("Powered by YourMom")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.bottom, -100)
                }
                .padding()
            }
        }
    }
}

// MARK: - Reusable Card Component
struct HomeCardView: View {
    let title: String
    let emoji: String
    let color: Color
    
    var body: some View {
        HStack {
            Text(emoji)
                .font(.system(size: 40))
            
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.leading, 10)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(color.opacity(0.8))
        .cornerRadius(16)
        .shadow(radius: 5)
    }
}

#Preview {
    ContentView()
}

