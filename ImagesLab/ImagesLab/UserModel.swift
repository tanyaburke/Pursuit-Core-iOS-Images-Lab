//
//  UserModel.swift
//  ImagesLab
//
//  Created by Tanya Burke on 12/14/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import Foundation

struct UserData : Decodable {
    let results: [User]
}

struct User: Decodable {
    let gender: String
    let name: Name
    
}
struct Name: Decodable { 
   let title: String
    let firstName: String
    let lastName: String
    
   private enum CodingKeys: String, CodingKey {
       case title
    case firstName = "first"
        case lastName = "last"
    }
}
