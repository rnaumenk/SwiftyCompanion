//
//  APIController.swift
//  SwiftyCompanion
//
//  Created by Ruslan NAUMENKO on 10/20/18.
//  Copyright © 2018 Ruslan NAUMENKO. All rights reserved.
//

import UIKit

class APIController {

    private let clientId = "0f40815735ef0c39845dace84ef00c3a0159d24beaee41212e6cab9e57b1dde4"
    private let clientSecret = "e0846625f495b3e5c77c58da26f37e41ec768a2bffe8bb97c0399063e1f38d80"
    private let dispatchGroup = DispatchGroup()
    
    /// Check wether token is alive
    func checkToken() {
        dispatchGroup.enter()
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
            getToken()
            dispatchGroup.wait()
            return
        }
        
        guard let tokenUrl = URL(string: "https://api.intra.42.fr/oauth/token/info") else {
            print("token/info URL error")
            return
        }
        
        var request = URLRequest(url: tokenUrl)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error!)
                self.dispatchGroup.leave()
                return
            }
            
            if let d = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? NSDictionary {
                        if json.value(forKey: "error") != nil {
                            self.getToken()
                        } else {
                            print("token is alive")
                            self.dispatchGroup.leave()
                        }
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
        
        dispatchGroup.wait()
    }
    
    /// Request a new token
    private func getToken() {
        guard let tokenUrl = URL(string: "https://api.intra.42.fr/oauth/token?grant_type=client_credentials") else {
            print("token URL error")
            return
        }
        
        let bearer = ((self.clientId + ":" + self.clientSecret).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        
        var request = URLRequest(url: tokenUrl)
        request.httpMethod = "POST"
        request.setValue("Basic " + bearer, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {return}
            if let d = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? NSDictionary {
                        print("new token has been created")
                        UserDefaults.standard.set(json["access_token"], forKey: "token")
                    }
                }
                catch let err {
                    print(err)
                }
            }
            self.dispatchGroup.leave()
        }.resume()
    }
    
    /// Download user info
    ///
    /// - Parameters:
    ///   - login: user information of whose is requested
    ///   - completion: returns user info on finish
    func getUser(_ login: String, completion: @escaping (NSDictionary?) -> Void) {

        guard let userUrl = URL(string: "https://api.intra.42.fr/v2/users/" + login) else {
            print("user URL error")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: userUrl)
        request.httpMethod = "GET"
        request.setValue("Bearer \(UserDefaults.standard.object(forKey: "token") as! String)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error!)
                completion(nil)
                return
            }
            if let d = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? NSDictionary {
                        completion(json)
                    }
                }
                catch let err {
                    print(err)
                }
            }
        }.resume()
    }

}
