//
//  PokemonListItem.swift
//  Globe Trotter
//
//  Created by Manan Jhaveri on 15/07/20.
//  Copyright © 2020 Manan Jhaveri. All rights reserved.
//

import Foundation

class PokemonListItem: NSObject, Codable, NSCoding{
    var name:String
    var url:String
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "PokemonName")
        coder.encode(url, forKey: "PokemonURL")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "PokemonName") as? String ?? ""
        url = coder.decodeObject(forKey: "PokemonURL") as? String ?? ""
    }
    
    func getName()->String{
        var name = self.name.replacingOccurrences(of: "-", with: " ")
        name = name.capitalized
        return name
    }
}

class PokemonList: NSObject, Codable, NSCoding{
    var results:[PokemonListItem]
    
    required init?(coder: NSCoder) {
        results = coder.decodeObject(forKey: "PokemonList") as! [PokemonListItem]
    }

    init(_ pokemonListItems:[PokemonListItem]){
        results = pokemonListItems
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(results, forKey: "PokemonList")
    }
}

class TypeSuper:Codable{
    var type:PokemonListItem?
}

class Sprite:Codable{
    var imageUrl:String?
    
    enum CodingKeys: String,CodingKey {
        case imageUrl = "front_default"
    }
}

class PokemonInfo: Codable{
    var name:String?
    var weight:Int?
    var height:Int?
    var id:Int?
    var types:[TypeSuper]?
    var sprites:Sprite
}
