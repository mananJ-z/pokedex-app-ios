//
//  RequestMaker.swift
//  Globe Trotter
//
//  Created by Manan Jhaveri on 15/07/20.
//  Copyright © 2020 Manan Jhaveri. All rights reserved.
//

import Foundation

class NetworkManager{
    
    static var shared = NetworkManager()
    var tasks = [(API,URLSessionTask)]()
    
    private init(){}
    
    func makeNetworkCall<T:Decodable>(api:API, completionHandler: @escaping (T?, Error?) -> Void){
        cancelTasksIfNeeded(for: api)
        
        let task = URLSession.shared.dataTask(with: buildURLRequest(api: api)) { (data, response, error) in
            if let error = error{
                print(error.localizedDescription)
                completionHandler(nil,error)
            }
            else{
                if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200{
                    do{
                        let decoded = try JSONDecoder().decode(T.self, from: data)
                        completionHandler(decoded,nil)
                    }
                    catch{
                        print("Decode Error")
                        completionHandler(nil,error)
                    }
                }
                else{
                    print("HTTP Request Failed")
                    completionHandler(nil, error)
                }
            }
        }
        
        tasks.append((api,task))
        task.resume()
    }
    
    private func buildURLRequest(api:API) -> URLRequest {
        var url = URLComponents(string: api.baseUrl)
        url?.queryItems = api.queryParameters.map({ URLQueryItem(name: $0.key, value: "\($0.value)")})
        
        var urlRequest = URLRequest(url: (url?.url)!)
        urlRequest.httpMethod = api.httpMethod
    
        return urlRequest
    }
    
    private func cancelTasksIfNeeded(for newApi: API){
        if newApi.allowsMultipleRequests{
            return
        }
        
        for i in 0..<tasks.count{
            let (api,task) = tasks[i]
            if newApi.apiIdentifier == api.apiIdentifier{
                task.cancel()
                tasks.remove(at: i)
                break
            }
        }
    }
}
