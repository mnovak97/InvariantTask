//
//  SearchBar.swift
//  InvariantTask
//
//  Created by Martin Novak on 22.01.2024..
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        HStack {
            TextField("Search...",text: $text)
                .padding(8)
                .padding(.horizontal,24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName:"magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
                        }
                    )
                
            }
        }
}

#Preview {
    SearchBar(text: .constant(""))
}
