//
//  PokemonListContollers.swift
//  Globe Trotter
//
//  Created by Manan Jhaveri on 17/07/20.
//  Copyright © 2020 Manan Jhaveri. All rights reserved.
//

import Foundation

class PokemonListDataController {
    weak var pokemonListControllerDelegate:PokemonListControllerDelegate?
    func setAllPokemon() throws{}
}

class PokemonListStorageLoader:PokemonListDataController{
    override func setAllPokemon() throws{
        if let pokemonList = try StorageManager.shared.getObjectFromKey(PokemonList.self, keyPath: UserDefaultKeys.POKEMON_LIST){
            pokemonListControllerDelegate?.loadData(pokemonItems: pokemonList.results)
        }
        else{
            throw NullError(PokemonList.self)
        }
    }
    
    func addPokemonListToStorage(pokemonListItems:[PokemonListItem]){
        let pokemonList = PokemonList(pokemonListItems)
        try! StorageManager.shared.setObjectWithKey(object: pokemonList, keyPath: UserDefaultKeys.POKEMON_LIST)
    }
}

class PokemonListNetworkLoader:PokemonListDataController{
    override func setAllPokemon() throws{
        NetworkManager.shared.makeNetworkCall(api: AllPokemonNamesAPI()){
            (pokeList: PokemonList?, error) in
            if let error = error{
                print(error.localizedDescription)
                self.pokemonListControllerDelegate?.showError(error: error)
            }
            else if pokeList==nil{
                print("HTTPError")
                self.pokemonListControllerDelegate?.showError(error: NullError(PokemonList.self))
            }
            else{
                DispatchQueue.main.async {
                    self.pokemonListControllerDelegate?.loadData(pokemonItems: pokeList!.results)
                    NotificationCenter.default.post(name: .SyncWithWiewComplete, object: self)
                }
            }
        }
    }
}
