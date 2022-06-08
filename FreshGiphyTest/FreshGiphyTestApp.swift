//
//  FreshGiphyTestApp.swift
//  FreshGiphyTest
//
//  Created by Naveen Kumawat on 07/06/22.
//

import SwiftUI

@main
struct FreshGiphyTestApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject var favViewModel = FavViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(favViewModel)
        }
    }
}
