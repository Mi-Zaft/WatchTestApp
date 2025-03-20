//
//  ContentView.swift
//  WatchTestApp
//
//  Created by Максим Евграфов on 20.03.2025.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject
    var viewModel = PhoneViewModel()
    
    var body: some View {
        List(viewModel.characterList) { character in
            HStack(spacing: 5) {
                AsyncImage(url: character.imageUrl) { result in
                    result.image?
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 40, height: 40)
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(character.name)
                    Text(character.status)
                        .foregroundStyle(Color.secondary)
                }
            }
        }.onAppear {
            viewModel.fetchCharacters()
        }
    }
}

#Preview {
    ContentView()
}
