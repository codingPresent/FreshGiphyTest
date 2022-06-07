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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
