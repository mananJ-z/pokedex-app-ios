//
//  NullError.swift
//  Globe Trotter
//
//  Created by Manan Jhaveri on 17/07/20.
//  Copyright © 2020 Manan Jhaveri. All rights reserved.
//

import Foundation

class NullError:Error{
    var typeString:String
    var localizedDescription: String{
        typeString + " object should not have been nil."
    }
    
    init<T>(_ type:T.Type){
        typeString = "\(type)"
    }
}
