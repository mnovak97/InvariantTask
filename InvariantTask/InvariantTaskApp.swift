//
//  InvariantTaskApp.swift
//  InvariantTask
//
//  Created by Martin Novak on 16.01.2024..
//

import SwiftUI

@main
struct InvariantTaskApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
        }
    }
}
