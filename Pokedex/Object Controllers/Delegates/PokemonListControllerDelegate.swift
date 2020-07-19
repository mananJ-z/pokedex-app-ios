//
//  ObjectControllerDelegate.swift
//  Globe Trotter
//
//  Created by Manan Jhaveri on 17/07/20.
//  Copyright © 2020 Manan Jhaveri. All rights reserved.
//

import Foundation

protocol PokemonListControllerDelegate:class{
    func loadData(pokemonItems:[PokemonListItem])
    func showError(error:Error)
}
