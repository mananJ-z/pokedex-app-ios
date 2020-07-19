//
//  DetailViewModel.swift
//  Globe Trotter
//
//  Created by Manan Jhaveri on 16/07/20.
//  Copyright © 2020 Manan Jhaveri. All rights reserved.
//

import Foundation
import UIKit

class DetailViewModel: PokemonDetailsControllerDelegate{
    var pokemon: PokemonListItem!
    var pokemonDetail: PokemonInfo?
    
    var storageController:PokemonDetailsStorageLoader!
    var networkController:PokemonDetailsNetworkLoader!
    
    weak var delegate: DetailViewModelDelegate?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(pushToStorage), name: .SyncWithWiewComplete, object: nil)
    }
    
    func fetchDataForView(){
        storageController = PokemonDetailsStorageLoader(pokemon)
        networkController = PokemonDetailsNetworkLoader(pokemon)
        
        storageController.pokemonDetailsControllerDelegate = self
        networkController.pokemonDetailsControllerDelegate = self
        
        delegate?.showLoader(isLoading: true)
        do{
            try storageController.setPokemonDetails()
        }catch{
            print("Missing data")
            try! networkController.setPokemonDetails()
        }
    }
    
    func loadImage(){
        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: URL(string: (self.pokemonDetail?.sprites.imageUrl)!)!)
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    self.delegate?.loadImage(image: image!)
                }
            }
            catch{
                print(error)
            }
        }
    }
    
    func loadData(pokemonInfo: PokemonInfo) {
        pokemonDetail = pokemonInfo
        
        self.delegate?.updateData()
        self.loadImage()
        self.delegate?.showLoader(isLoading: false)
    }
    
    func showError(error: Error) {
        print(error.localizedDescription)
        self.delegate?.showError()
    }
    
    @objc func pushToStorage(_ notification:  Notification){
        if let _ = notification.object as? PokemonDetailsNetworkLoader{
            storageController.addPokemonDetailsToStorage(pokemonDetails: pokemonDetail!)
            print("Loaded to memory")
        }
    }
}
