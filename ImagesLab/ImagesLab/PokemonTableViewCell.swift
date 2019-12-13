//
//  PokemonTableViewCell.swift
//  ImagesLab
//
//  Created by Tanya Burke on 12/13/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

  @IBOutlet weak var pokemonImageView: UIImageView!
    
    
    
//    var pokemoncard: Card()
    func configureCell(card: PokemonCard){
        
        pokemonImageView.getImage(with: card.imageUrl) { [weak self] (result) in
            switch result{
            case .failure:
                DispatchQueue.main.sync{
                self?.pokemonImageView.image = UIImage(systemName: "exclamationmark.triangle")
            }
            case .success(let cellImage):
               
                DispatchQueue.main.async {
                    self?.pokemonImageView.image = cellImage
                    
                }
        }
        
    }
        
}


}
          
