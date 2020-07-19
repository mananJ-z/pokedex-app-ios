//
//  PokemonDetailsControllerDelegate.swift
//  Globe Trotter
//
//  Created by Manan Jhaveri on 18/07/20.
//  Copyright © 2020 Manan Jhaveri. All rights reserved.
//

import Foundation

protocol PokemonDetailsControllerDelegate:class{
    func loadData(pokemonInfo: PokemonInfo)
    func showError(error:Error)
}
