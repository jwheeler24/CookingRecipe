# Cooking Recipe App (Powered by TheMealDB)

A SwiftUI iOS application that lets you browse and view recipes from [TheMealDB](https://www.themealdb.com/).  
The app is designed for easy navigation with a clean, modern UI.

---

## Features

- **Home Screen**
  - Gradient background with a large title.
  - Three main navigation options:
    - Browse by Category
    - Browse by Area
    - Browse by Ingredient
  - Footer: "Powered by TheMealDB"

- **Category List**
  - Fetches and displays all recipe categories from TheMealDB.
  - Tap a category to view all meals in that category.

- **Area List**
  - Displays available areas/regions (e.g., Canadian, Italian, American).
  - Tap an area to view meals from that region.

- **Ingredient List**
  - Displays available ingredients (e.g., Chicken, Beef, Rice).
  - Tap an ingredient to view meals that use it.

- **Meal List**
  - Shows meals with thumbnail images and names based on selected Category, Area, or Ingredient.
  - Tap a meal to view details.

- **Meal Detail**
  - Shows:
    - Large meal image
    - Recipe name
    - Cooking instructions
  - Future feature: ingredients and measurements list.
  - Supports scroll (can be extended with hands-free gesture scrolling).

---

## Tech Stack

- SwiftUI for UI
- AVFoundation & Vision (optional feature) for hand gesture scrolling
- TheMealDB API as the data source

---

## API Endpoints Used

- Categories → `https://www.themealdb.com/api/json/v1/1/list.php?c=list`
- Areas → `https://www.themealdb.com/api/json/v1/1/list.php?a=list`
- Ingredients → `https://www.themealdb.com/api/json/v1/1/list.php?i=list`
- Meals by filter → `https://www.themealdb.com/api/json/v1/1/filter.php?c=Beef`
- Meal detail by ID → `https://www.themealdb.com/api/json/v1/1/lookup.php?i=52772`

---

## Getting Started

1. Clone the repository.
2. Open the project in **Xcode**.
3. Run on **iOS Simulator** or a real device.
4. Make sure you have an internet connection (TheMealDB is an online API).

---

## Screenshots (todo)

---

## Attribution

This app uses the free [TheMealDB](https://www.themealdb.com/) API. 
