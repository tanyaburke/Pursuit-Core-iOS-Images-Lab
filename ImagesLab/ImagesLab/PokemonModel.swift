//
//  PokemonModel.swift
//  ImagesLab
//
//  Created by Tanya Burke on 12/13/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import Foundation


struct PokemonData: Decodable {
  
    var cards:[PokemonCard]
}

struct PokemonCard: Decodable {
   var name:String
    var imageUrl: String //for tableview cells
    var imageUrlHiRes: String//for detail view
    var types: [String]?
    var set: String
    var weaknesses: [Weakness]?
    
}
//struct Type:Decodable{
//   var type: String
//}
struct Weakness : Decodable {
    var type: String
    var value:String
}
    
    
