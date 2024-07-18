//
//  PokemonModel.swift
//  TechnicalTask
//
//  Created by Bharat Jadav on 17/07/2024.
//

import Foundation

struct PokemonModel : Codable {
    let count : Int?
    let next : String?
    let previous : String?
    let results : [ResultList]?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        next = try values.decodeIfPresent(String.self, forKey: .next)
        previous = try values.decodeIfPresent(String.self, forKey: .previous)
        results = try values.decodeIfPresent([ResultList].self, forKey: .results)
    }
}

struct ResultList : Codable, Identifiable {
    let id      = UUID()
    let name : String?
    let url : String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    static func tempData() -> ResultList {
        return ResultList(name: "Pokemon", url: "https://pokeapi.co/api/v2/pokemon/21/")
    }
}
