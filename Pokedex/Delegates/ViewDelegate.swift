//
//  ViewDelegate.swift
//  Globe Trotter
//
//  Created by Manan Jhaveri on 16/07/20.
//  Copyright © 2020 Manan Jhaveri. All rights reserved.
//

import Foundation
import UIKit

protocol ModelDelegate:class{
    func showLoader(isLoading:Bool)
    func updateData()
    func showError()
}

extension ModelDelegate{
    func showError(){}
}

protocol DetailViewModelDelegate:ModelDelegate {
    func loadImage(image:UIImage)
}
