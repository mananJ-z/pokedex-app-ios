//
//  API Implementations.swift
//  Globe Trotter
//
//  Created by Manan Jhaveri on 17/07/20.
//  Copyright © 2020 Manan Jhaveri. All rights reserved.
//

import Foundation

class AllPokemonNamesAPI:API{
    var apiIdentifier:Int{
        100
    }
    
    var baseUrl: String{
        "https://pokeapi.co/api/v2/pokemon"
    }
    
    var httpMethod: String{
        "GET"
    }
    
    var queryParameters: [String : Any]{
        ["limit": 10000]
    }
}

class PokemonDetailsAPI:API{
    var apiIdentifier:Int{
        101
    }
    
    var baseUrl: String
    
    init(baseUrl:String) {
        self.baseUrl = baseUrl
    }
    
    var httpMethod: String{
        "GET"
    }
    
    var queryParameters: [String : Any]{
        [:]
    }
}
