//
//  ContentView.swift
//  FreshGiphyTest
//
//  Created by Naveen Kumawat on 07/06/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var favViewModel: FavViewModel
    @StateObject var trendingData = TrendingViewModel()

    var body: some View {
        TabView {
            TrendingView()
                .tabItem {
                    Image(systemName: "photo.fill.on.rectangle.fill")
                    Text("Trending")
                }
                .environmentObject(trendingData)
                .environmentObject(favViewModel)
            FavouriteView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
                .environmentObject(favViewModel)
        }
    }
}

