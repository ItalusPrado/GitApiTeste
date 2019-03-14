//
//  RequestManager.swift
//  GitApiTeste
//
//  Created by Italus Rodrigues do Prado on 12/03/19.
//  Copyright © 2019 Italus Rodrigues do Prado. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager{
    
    static func requestList(path: String, completion : @escaping ([NSDictionary]?, Bool)->Void){
        
        Alamofire.request(path, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result{
            case .success(let JSON):
                if let jsonArray = JSON as? [NSDictionary]{
                    completion(jsonArray, true)
                }
                completion(nil, false)
            case .failure(_):
                completion(nil, false)
            }
        }
    }
    
    static func requestUserInformation(nick: String, completion : @escaping (NSDictionary)->Void){
    
        Alamofire.request(Github.listUsers+"/"+nick, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result{
            case .success(let JSON):
                if let jsonArray = JSON as? NSDictionary{
                    completion(jsonArray)
                }
            case .failure(let ERROR):
                print(ERROR)
            }
        }
    }
    
    static func requestRepos(nick: String, completion : @escaping ([NSDictionary])->Void){
        Alamofire.request(Github.listUsers+"/"+nick+"/repos", method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result{
            case .success(let JSON):
                if let jsonArray = JSON as? [NSDictionary]{
                    completion(jsonArray)
                }
            case .failure(let ERROR):
                print(ERROR)
            }
        }
    }
}
