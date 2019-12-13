//
//  PokemonViewController.swift
//  ImagesLab
//
//  Created by Tanya Burke on 12/13/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonCards = [PokemonCard](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
        }
    }
    var searchQuery = "" {
        didSet{
            pokemonCards = pokemonCards.filter{$0.name.lowercased().contains(searchQuery.lowercased())}
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPokemonCards()
        tableView.dataSource = self
        searchBar.delegate = self

}
     private func loadPokemonCards(){
        PokemonAPI.fetchPokemonCards{[weak self] result in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async{
                    self?.showAlert(title:"AppError", message:"\(appError)")
                }
            case .success(let pokemonCards):
                self?.pokemonCards = pokemonCards
            }
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("failed to pass pokemonCard to detailVC ")
        }
        detailVC.pokemonCard = pokemonCards[indexPath.row]

    }
}
extension PokemonViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemonCards.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonTableViewCell else {
                   fatalError("could not deque a pokemon cell")
               }
               let pokemonCard = pokemonCards[indexPath.row]
               cell.configureCell(card: pokemonCard)
               return cell
           }
       }
    
extension PokemonViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
          loadPokemonCards()
        }
        searchQuery = searchText
        
    }
}


