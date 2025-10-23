//
//  AreaListView.swift
//  CookingReciept
//
//  Created by Jacob Wheeler on 10/3/25.
//

import SwiftUI

struct AreaListView: View {
    @State private var areas: [AreaItem] = []
    
    var body: some View {
        List(areas) { area in
            NavigationLink(destination: MealListView(filterType: "a", filterValue: area.strArea)) {
                Text(area.strArea)
            }
        }
        .navigationTitle("Areas")
        .onAppear {
            MealDBAPI.fetch(
                url: "https://www.themealdb.com/api/json/v1/1/list.php?a=list",
                decodeType: AreaResponse.self
            ) { result in
                areas = result?.meals ?? []
            }
        }
    }
}
