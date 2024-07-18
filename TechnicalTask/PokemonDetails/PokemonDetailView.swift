//
//  PokemonDetailView.swift
//  TechnicalTask
//
//  Created by Bharat Jadav on 17/07/2024.
//

import SwiftUI

struct PokemonDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var viewModel: PokemonViewModel? = PokemonViewModel()
    @State var items: ResultList
    @State var sprites: Sprite
    
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        })
        {
            HStack {
                Image(K.imgNames.backButton)
                    .aspectRatio(contentMode: .fit)
                Text("Back")
                    .font(.headline)
                    .foregroundColor(Color.init(.black))
            }
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    HStack {
                        Text(items.name?.capitalized ?? "")
                            .font(.largeTitle)
                            .padding(.leading)
                        Spacer()
                    }
                    HStack {
                        AsyncImage(url: URL(string: self.sprites.frontDefault ?? "")){ image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    }
                    HStack {
                        Text("Statistics")
                            .font(.largeTitle)
                            .padding(.leading)
                        Spacer()
                    }
                    ForEach(self.viewModel?.pokemonDetails?.stats ?? []) { item in
                        PokemonStatsCell(result: item)
                    }
                }
            }
        }
        .padding(.top, 10)
        .navigationBarTitle("Pokemon Details", displayMode: .inline)
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            self.getSearchedPokemon(strSearch: items.name?.lowercased() ?? "")
        })
    }
}
    
//MARK:- Service Call
extension PokemonDetailView {
    func getSearchedPokemon(strSearch: String) {
        self.viewModel?.getPokemonDetails(value: "/" + strSearch ,completion: { (success, error) in
            if success {
                self.sprites = self.viewModel?.pokemonDetails?.sprites ?? Sprite.tempData()
            }
        })
    }
}

#Preview {
    PokemonDetailView(items: ResultList.tempData(), sprites: Sprite.tempData())
}
