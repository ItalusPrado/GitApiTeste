//
//  User.swift
//  GitApiTeste
//
//  Created by Italus Rodrigues do Prado on 12/03/19.
//  Copyright © 2019 Italus Rodrigues do Prado. All rights reserved.
//

import Foundation

class User {
    
    let id: Int?
    let login: String?
    let node_id: String?
    let avatar_url: String?
    let gravatar_id: String?
    let url: String?
    let html_url: String?
    let followers_url: String?
    let following_url: String?
    let gists_url: String?
    let starred_url: String?
    let subscriptions_url: String?
    let organizations_url: String?
    let repos_url: String?
    let events_url: String?
    let received_events_url: String?
    let type: String?
    let site_admin: Bool?
    
    var details: NSDictionary?
    
    init(dict: NSDictionary) {
        
        self.id = dict["id"] as? Int ?? nil
        self.login = dict["login"] as? String ?? nil
        self.node_id = dict["node_id"] as? String ?? nil
        self.avatar_url = dict["avatar_url"] as? String ?? nil
        self.gravatar_id = dict["gravatar_id"] as? String ?? nil
        self.url = dict["url"] as? String ?? nil
        self.html_url = dict["html_url"] as? String ?? nil
        self.followers_url = dict["followers_url"] as? String ?? nil
        self.following_url = dict["following_url"] as? String ?? nil
        self.gists_url = dict["gists_url"] as? String ?? nil
        self.starred_url = dict["starred_url"] as? String ?? nil
        self.subscriptions_url = dict["subscriptions_url"] as? String ?? nil
        self.organizations_url = dict["organizations_url"] as? String ?? nil
        self.repos_url = dict["repos_url"] as? String ?? nil
        self.events_url = dict["events_url"] as? String ?? nil
        self.received_events_url = dict["received_events_url"] as? String ?? nil
        self.type = dict["type"] as? String ?? nil
        self.site_admin = dict["site_admin"] as? Bool ?? nil
    }
    
    func getDetails(){
        RequestManager.requestUserInformation(url: Github.listUsers+"/"+self.login, method: .get) { (response) in
            self.
        }
    }
}

class UserDetails{
    
    let name: String?
    let company: String?
    let blog: String?
    let location: String?
    let email: String?
    let hireable: String?
    let bio: String?
    let public_repos: Int?
    let public_gists: Int?
    let followers: Int?
    let following: Int?
    let created_at: String?
    let updated_at: String?
    
    init(dict: NSDictionary) {
        self.name = dict["id"] as? String ?? nil
        self.company = dict["company"] as? String ?? nil
        self.blog = dict["blog"] as? String ?? nil
        self.location = dict["location"] as? String ?? nil
        self.email = dict["email"] as? String ?? nil
        self.hireable = dict["hireable"] as? String ?? nil
        self.bio = dict["bio"] as? String ?? nil
        self.public_repos = dict["public_repos"] as? Int ?? nil
        self.public_gists = dict["public_gists"] as? Int ?? nil
        self.followers = dict["followers"] as? Int ?? nil
        self.following = dict["following"] as? Int ?? nil
        self.created_at = dict["created_at"] as? String ?? nil
        self.updated_at = dict["updated_at"] as? String ?? nil
    }
}
