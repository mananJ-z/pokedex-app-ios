//
//  MainViewControllerDelegates.swift
//  Globe Trotter
//
//  Created by Manan Jhaveri on 15/07/20.
//  Copyright © 2020 Manan Jhaveri. All rights reserved.
//

import UIKit

extension ViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: ViewController.reuseIdentifier, for: indexPath)
        
        let (pi, i) = viewModel.getPokemonAtIndex(index: indexPath.row)
        
        tableViewCell.textLabel?.numberOfLines = 0
        tableViewCell.textLabel?.text =
        """
        \(pi.getName())
        #\(String(format: "%03d",1 + i))
        """
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        (detailViewController.viewModel.pokemon , _) = viewModel.getPokemonAtIndex(index: indexPath.row)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            viewModel.searchPokemon(text: text)
        }
        else {
            viewModel.cancelSearch()
        }
    }
}
