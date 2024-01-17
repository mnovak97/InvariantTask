//
//  ContentView.swift
//  InvariantTask
//
//  Created by Martin Novak on 16.01.2024..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                ShoppingListView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                    }
                NotesView()
                    .tabItem {
                        Image(systemName: "note.text")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
