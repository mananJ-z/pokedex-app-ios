//
//  DetailViewController.swift
//  Globe Trotter
//
//  Created by Manan Jhaveri on 16/07/20.
//  Copyright © 2020 Manan Jhaveri. All rights reserved.
//

import UIKit

class DetailViewController:UIViewController, DetailViewModelDelegate{
    let label = UILabel()
    let imageView = UIImageView()
    let loadingView = UIActivityIndicatorView(style: .large)
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutViews()
        viewModel.delegate = self
        
        viewModel.fetchDataForView()
    }
    
    func layoutViews(){
        title = viewModel.pokemon?.getName()
        
        view.addSubview(label)
        view.addSubview(imageView)
        view.addSubview(loadingView)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        
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
        var typeText = ""
        let pokemonDetail = viewModel.pokemonDetail
        for type in pokemonDetail!.types!{
            typeText += (type.type?.getName())! + " "
        }
        
        label.text =
        """
        \(viewModel.pokemon!.getName())
        #\(String(format: "%03d", pokemonDetail?.id ?? 0))
        Height: \(pokemonDetail!.height ?? 0)
        Weight: \(pokemonDetail!.weight ?? 0)
        Type: \(typeText)
        """
        
        label.textAlignment = .center
    }
    
    func loadImage(image: UIImage) {
        imageView.image = image
    }
    
    func showError() {
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
