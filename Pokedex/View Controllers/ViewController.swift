//
//  ViewController.swift
//  Globe Trotter
//
//  Created by Manan Jhaveri on 15/07/20.
//  Copyright © 2020 Manan Jhaveri. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ModelDelegate {
    static let reuseIdentifier = "TableViewCell"
    let tableView = UITableView()
    let loadingView = UIActivityIndicatorView(style: .large)
    let viewModel = RootViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        layoutViews()
        
        viewModel.delegate = self
        viewModel.fetchDataForView()
    }
    
    func layoutViews(){
        title = "Pokemon"
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = search
        
        view.addSubview(tableView)
        view.addSubview(loadingView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ViewController.reuseIdentifier)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive=true
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        
        view.backgroundColor = .white
    }
    
    func showLoader(isLoading: Bool) {
        if isLoading{
            loadingView.isHidden = false
            loadingView.startAnimating()
        }
        else{
            loadingView.stopAnimating()
            loadingView.isHidden = true
        }
    }
    
    func updateData() {
        tableView.reloadData()
    }
    
    func showError() {
        print("Hello from showError")
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Something wrong happened. Could not fetch data. Check your internet connection and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
                self.viewModel.fetchDataForView()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

