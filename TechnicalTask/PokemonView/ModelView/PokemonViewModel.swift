//
//  PokemonViewModel.swift
//  TechnicalTask
//
//  Created by Bharat Jadav on 17/07/2024.
//

import Foundation

class PokemonViewModel : NSObject, ObservableObject {
    var pokemonData : PokemonModel?
    var pokemonDetails: PokemonDetailsModel?
    
    // MARK:- server request for fetch pokemon list
    func getPokemonList(value: String, completion: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        APIService.shared.requestWithGet(resourceType: .pokemonAPI, value: value, requestType: .get, completion: { (result:Result<PokemonModel?, Error>) in
            switch result {
            case .success(let response):
                guard let resData = response else {
                    return
                }
                self.pokemonData = resData
                return completion(true, nil)
            case .failure(let error):
                AppUtility.shared.printToConsole(error)
                return completion(false, nil)
            }
        })
    }
    
    // MARK:- server request for fetch pokemon details with searched text
    func getPokemonDetails(value: String, completion: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        APIService.shared.requestWithGet(resourceType: .pokemonAPI, value: value, requestType: .get, completion: { (result:Result<PokemonDetailsModel?, Error>) in
            switch result {
            case .success(let response):
                guard let resData = response else {
                    return
                }
                self.pokemonDetails = resData
                return completion(true, nil)
            case .failure(let error):
                AppUtility.shared.printToConsole(error)
                return completion(false, nil)
            }
        })
    }
}
