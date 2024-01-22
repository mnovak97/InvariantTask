//
//  NotesCard.swift
//  InvariantTask
//
//  Created by Martin Novak on 22.01.2024..
//

import SwiftUI

struct NotesCard: View {
    let title: String
    let note: String
    let linkedItems: Int
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(title)
                    .modifier(MainTextStyle())
                Spacer()
            }
            HStack {
                Text("Note: \(note)")
                    .modifier(TextStyle())
                Spacer()
            }
            HStack {
                Text("Linked items: \(linkedItems)")
                    .modifier(TextStyle())
                Spacer()
            }
        }
        .modifier(CardStyle())
    }
}

#Preview {
    NotesCard(title: "Title", note: "Note", linkedItems: 0)
}
