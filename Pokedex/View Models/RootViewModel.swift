//
//  RootViewModel.swift
//  Globe Trotter
//
//  Created by Manan Jhaveri on 16/07/20.
//  Copyright © 2020 Manan Jhaveri. All rights reserved.
//

import Foundation

class RootViewModel: PokemonListControllerDelegate{
    var pokemon: [PokemonListItem] = []
    var filteredPokemon: [PokemonListItem] = []
    
    let storageController = PokemonListStorageLoader()
    let networkController = PokemonListNetworkLoader()
    
    weak var delegate:ModelDelegate?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(pushToStorage), name: .SyncWithWiewComplete, object: nil)
    }
    
    func fetchDataForView(){
        delegate?.showLoader(isLoading: true)
        
        storageController.pokemonListControllerDelegate = self
        networkController.pokemonListControllerDelegate = self
        
        do{
            try storageController.setAllPokemon()
        }catch{
            print("Missing data")
            
            try! networkController.setAllPokemon()
        }
    }
    
    func getCount()->Int{
        return filteredPokemon.count
    }
    
    func getPokemonAtIndex(index:Int)->(PokemonListItem, Int){
        return (filteredPokemon[index], (pokemon.firstIndex(of: filteredPokemon[index]) ?? 0))
    }
    
    func searchPokemon(text:String){
        filteredPokemon = pokemon.filter{ (pokemon) -> Bool in
            return pokemon.name.contains(text.lowercased())
        }
        
        delegate?.updateData()
    }
    
    func cancelSearch(){
        filteredPokemon = pokemon
        
        delegate?.updateData()
    }
    
    func loadData(pokemonItems: [PokemonListItem]) {
        delegate?.showLoader(isLoading: false)
        self.pokemon = pokemonItems
        filteredPokemon = pokemonItems
        
        delegate?.updateData()
    }
    
    func showError(error: Error) {
        print(error)
        delegate?.showError()
    }
    
    @objc func pushToStorage(_ notification:  Notification){
        if let _ = notification.object as? PokemonListNetworkLoader{
            storageController.addPokemonListToStorage(pokemonListItems: pokemon)
            print("Loaded to memory")
        }
    }
}
