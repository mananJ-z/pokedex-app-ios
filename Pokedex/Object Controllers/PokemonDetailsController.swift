//
//  PokemonDetailsController.swift
//  Globe Trotter
//
//  Created by Manan Jhaveri on 18/07/20.
//  Copyright © 2020 Manan Jhaveri. All rights reserved.
//

import Foundation

class PokemonDetailsDataController {
    let pokemon:PokemonListItem
    
    init(_ pokemon:PokemonListItem){
        self.pokemon = pokemon
    }
    
    weak var pokemonDetailsControllerDelegate:PokemonDetailsControllerDelegate?
    func setPokemonDetails() throws{}
}

class PokemonDetailsStorageLoader:PokemonDetailsDataController{
    override func setPokemonDetails() throws {
        if let pokemonInfo = try StorageManager.shared.getObjectFromKey(PokemonInfo.self, jsonKeyPath: pokemon.url){
            pokemonDetailsControllerDelegate?.loadData(pokemonInfo: pokemonInfo)
        }
        else{
            throw NullError(PokemonInfo.self)
        }
    }
    
    func addPokemonDetailsToStorage(pokemonDetails:PokemonInfo){
        try! StorageManager.shared.setObjectWithKey(jsonObject: pokemonDetails, keyPath: pokemon.url)
    }
}

class PokemonDetailsNetworkLoader:PokemonDetailsDataController{
    override func setPokemonDetails() throws {
        NetworkManager.shared.makeNetworkCall(api: PokemonDetailsAPI(baseUrl: pokemon.url)){
            (pokeInfo: PokemonInfo?, error) in
            if let error = error{
                print(error.localizedDescription)
                self.pokemonDetailsControllerDelegate?.showError(error: error)
            }
            else if pokeInfo==nil{
                print("HTTPError")
                self.pokemonDetailsControllerDelegate?.showError(error: NullError(PokemonInfo.self))
            }
            else{
                DispatchQueue.main.async {
                    self.pokemonDetailsControllerDelegate?.loadData(pokemonInfo: pokeInfo!)
                    NotificationCenter.default.post(name: .SyncWithWiewComplete, object: self)
                }
            }
        }
    }
}
