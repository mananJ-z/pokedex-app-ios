//
//  API.swift
//  Globe Trotter
//
//  Created by Manan Jhaveri on 16/07/20.
//  Copyright © 2020 Manan Jhaveri. All rights reserved.
//

import Foundation

protocol API{
    var apiIdentifier:Int { get }
    
    var baseUrl:String { get }
    var httpMethod:String { get }
    var queryParameters:[String:Any] { get }
    
    var allowsMultipleRequests:Bool { get }
}

extension API{
    var allowsMultipleRequests:Bool{
        false
    }
}
