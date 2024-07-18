//
//  ContentView.swift
//  TechnicalTask
//
//  Created by Bharat Jadav on 16/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel: PokemonViewModel? = PokemonViewModel()
    @State var arrResult    : [ResultList] = []
    @State var loadStatus: K.LoadStatus = .notDetermine
    @State var offset: Int = 0
    @State var searchtxt:String = ""
    
    @Environment(\.dismissSearch) private var dismissSearch
    @Environment(\.isSearching) private var isSearching: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(arrResult) { item in
                        NavigationLink {
                            PokemonDetailView(items: item, sprites: Sprite.tempData())
                        } label: {
                            PokemonCell(result: item)
                        }
                    }
                    .onAppear(perform: {})
                    HStack {
                        Button(action: {}) {
                            Text("Previous")
                        }
                        .onTapGesture {
                            offset -= 20
                            self.getPokemonList()
                        }
                        .opacity(offset <= 0 ? 0 : 1)
                        Spacer()
                        Button(action: {}) {
                            Text("Next")
                        }
                        .onTapGesture {
                            offset += 20
                            self.getPokemonList()
                        }
                        .opacity(offset == -1 ? 0 : 1)
                    }
                }
                .searchable(text: $searchtxt, prompt: "Search...")
                .onSubmit(of: .search) {
                    print(searchtxt)
                    offset = -1
                    self.getSearchedPokemon(strSearch: searchtxt.lowercased())
                }
                .onChange(of: searchtxt, {
                    if searchtxt.isEmpty && !isSearching {
                        offset = 0
                        self.getPokemonList()
                    }
                })
            }
            .opacity(loadStatus == .isAvailable ? 1 : 0)
            .navigationBarTitle("Pokemon List", displayMode: .automatic)
        }
        .onAppear(perform: {
            self.getPokemonList()
        })

    }
}

//MARK:- Service Call
extension ContentView {
    func getPokemonList() {
        self.viewModel?.getPokemonList(value: "?offset=" + String(offset) + "&limit=20" ,completion: { (success, error) in
            if success {
                self.arrResult = self.viewModel?.pokemonData?.results ?? []
                self.loadStatus = self.arrResult.count == 0 ? .isEmpty : .isAvailable
            }
        })
    }
    
    func getSearchedPokemon(strSearch: String) {
        self.viewModel?.getPokemonDetails(value: "/" + strSearch ,completion: { (success, error) in
            if success {
                self.arrResult = [self.viewModel?.pokemonDetails?.species ?? ResultList.tempData()]
                self.loadStatus = self.arrResult.count == 0 ? .isEmpty : .isAvailable
            }
        })
    }
}

#Preview {
    ContentView()
}
