//
//  DetailViewController.swift
//  ImagesLab
//
//  Created by Tanya Burke on 12/13/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
 
    
    var pokemonCard: PokemonCard?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        detailLoad()
       
    }
    
    func detailLoad(){
        
        guard let card = pokemonCard else {
            fatalError("failed to access segued card")
        }
      imageView.getImage(with: card.imageUrlHiRes, completion: { [weak self](result) in
            switch result {
            case .failure:
            DispatchQueue.main.sync{
            self?.imageView.image = UIImage(systemName: "exclamationmark.triangle")
            }
            case .success(let image):
                DispatchQueue.main.async {
                    
                    self?.imageView.image = image
                }
               
        }
            })
        
        nameLabel?.text = card.name
        typesLabel?.text = "Type: \(card.types?.first ?? "none")\n Weakness:\n\tType: \(card.weaknesses?.first?.type ?? "none")\n\tValue: \(card.weaknesses?.first?.value ?? "none")\nSet: \(card.set)"
            }
       

}
    

