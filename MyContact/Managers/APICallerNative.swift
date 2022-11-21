//
//  APICallerNative.swift
//  MyContact
//
//  Created by Alwi Shihab on 21/11/22.
//


import Foundation

struct Constants{
    static let BASE_URL = "https://randomuser.me"
}

enum APIError: Error{
    case failedToGetData
}

class APICaller{
    static let shared = APICaller()
    
    func getContactList(compeletion: @escaping (Result<[Contacts], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.BASE_URL)/api?results=20&exc=login&nat=us&noinfo") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let results = try JSONDecoder().decode(ContactListResponse.self, from: data)
                compeletion(.success(results.results))
//                print("Contacts \(results.results.count)")
            }catch{
                compeletion(.failure(APIError.failedToGetData))
                print("failed")
            }
        }
        task.resume()
    }
    
}
