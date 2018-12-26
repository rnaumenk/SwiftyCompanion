//
//  UserModel.swift
//  SwiftyCompanion
//
//  Created by Ruslan on 18.11.2018.
//  Copyright © 2018 Ruslan NAUMENKO. All rights reserved.
//

import Foundation

struct UserModel {
    let imageURL: String
    let displayname: String
    let login: String
    let wallet: String
    let correctionPoints: String
    let phone: String
    let email: String
    let level: String
    let skills: NSArray
    let projects: [NSDictionary]
    
    
    init(_ user: NSDictionary) {
        imageURL = user["image_url"] as! String
        displayname = user["displayname"] as! String
        login = user["login"] as! String
        wallet = String(user["wallet"] as! Int)
        correctionPoints = String(user["correction_point"] as! Int)
        phone = user["phone"] as? String ?? ""
        email = user["email"] as! String
        level = String(format: "%.2f", (((user["cursus_users"] as! NSArray)[0] as! NSDictionary)["level"] as! NSNumber).floatValue)
        skills = ((user["cursus_users"] as! NSArray)[0] as! NSDictionary)["skills"] as! NSArray
        
        let allPossibleProjects = user["projects_users"] as! NSArray
        var validProjects = Array<NSDictionary>()
        
        for elem in allPossibleProjects {
            let elem = elem as! NSDictionary
            let project = elem["project"] as! NSDictionary
            
            if project["parent_id"] as? NSNull != nil && (project["name"] as? String) != "Rushes" && !((project["slug"] as! String).hasPrefix("piscine-c-")) && elem["validated?"] as? NSNull == nil {
                validProjects.append(elem)
            }
        }
        projects = validProjects
    }
    
}
