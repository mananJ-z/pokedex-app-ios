//
//  StorageManager.swift
//  Globe Trotter
//
//  Created by Manan Jhaveri on 16/07/20.
//  Copyright © 2020 Manan Jhaveri. All rights reserved.
//

import Foundation

class StorageManager{
    static let shared = StorageManager()
    let userDefaults = UserDefaults.standard
    
    private init(){
        
    }
    
    func isValueValid(keyPath:String)->Bool{
        if let lastFetchDate = userDefaults.object(forKey: "TIME_\(keyPath)") as? Date,
            abs(lastFetchDate.timeIntervalSinceNow) <= UserDefaultKeys.TIME_INTERVAL{
            return true
        }
        
        return false
    }
    
    func getObjectFromKey<T:NSCoding>(_ type: T.Type, keyPath: String) throws -> T?{
        if isValueValid(keyPath: keyPath), let data = userDefaults.object(forKey: keyPath) as? Data{
            return NSKeyedUnarchiver.unarchiveObject(with: data) as? T
        }
        
        return nil
    }
    
    func setObjectWithKey<T:NSCoding>(object: T, keyPath: String) throws{
        let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
        userDefaults.set(data, forKey: keyPath)
        userDefaults.set(Date(), forKey: "TIME_\(keyPath)")
    }
    
    func getObjectFromKey<T:Decodable>(_ type: T.Type, jsonKeyPath: String) throws -> T?{
        if isValueValid(keyPath: jsonKeyPath), let data = userDefaults.object(forKey: jsonKeyPath) as? Data{
            return try? JSONDecoder().decode(T.self, from: data)
        }
        
        return nil
    }
    
    func setObjectWithKey<T:Encodable>(jsonObject: T, keyPath: String) throws{
        let data = try JSONEncoder().encode(jsonObject)
        userDefaults.set(data, forKey: keyPath)
        userDefaults.set(Date(), forKey: "TIME_\(keyPath)")
    }
}
