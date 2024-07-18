//
//  PokemonDetailsModel.swift
//  TechnicalTask
//
//  Created by Bharat Jadav on 18/07/2024.
//

import Foundation

struct PokemonDetailsModel : Codable {
    let id : Int?
    let isDefault : Bool?
    let locationAreaEncounters : String?
    let name : String?
    let order : Int?
    let species : ResultList?
    let sprites : Sprite?
    let stats : [Stat]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case name = "name"
        case order = "order"
        case species = "species"
        case sprites = "sprites"
        case stats = "stats"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        isDefault = try values.decodeIfPresent(Bool.self, forKey: .isDefault)
        locationAreaEncounters = try values.decodeIfPresent(String.self, forKey: .locationAreaEncounters)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        species = try values.decodeIfPresent(ResultList.self, forKey: .species)
        sprites = try values.decodeIfPresent(Sprite.self, forKey: .sprites)
        stats = try values.decodeIfPresent([Stat].self, forKey: .stats)
    }
}

struct Sprite : Codable {
    let backDefault : String?
    let backShiny : String?
    let frontDefault : String?
    let frontShiny : String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        backDefault = try values.decodeIfPresent(String.self, forKey: .backDefault)
        backShiny = try values.decodeIfPresent(String.self, forKey: .backShiny)
        frontDefault = try values.decodeIfPresent(String.self, forKey: .frontDefault)
        frontShiny = try values.decodeIfPresent(String.self, forKey: .frontShiny)
    }
    
    init(backDefault: String, backShiny: String, frontDefault: String, frontShiny: String) {
        self.backDefault = backDefault
        self.backShiny = backShiny
        self.frontDefault = frontDefault
        self.frontShiny = frontShiny
    }
    
    static func tempData() -> Sprite {
        return Sprite(backDefault: "String", backShiny: "String", frontDefault: "String", frontShiny: "String")
    }
}

struct Stat : Codable, Identifiable {
    var id = UUID()
    let baseStat : Int?
    let effort : Int?
    let stat : ResultList?

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort = "effort"
        case stat = "stat"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        baseStat = try values.decodeIfPresent(Int.self, forKey: .baseStat)
        effort = try values.decodeIfPresent(Int.self, forKey: .effort)
        stat = try values.decodeIfPresent(ResultList.self, forKey: .stat)
    }
    
    init(baseStat: Int, effort: Int, stat: ResultList) {
        self.baseStat = baseStat
        self.effort = effort
        self.stat = stat
    }
    
    static func tempData() -> Stat {
        return Stat(baseStat: 1, effort: 12, stat: ResultList.tempData())
    }
}
