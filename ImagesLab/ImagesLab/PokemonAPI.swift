//
//  PokemonAPI.swift
//  ImagesLab
//
//  Created by Tanya Burke on 12/13/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import Foundation

struct PokemonAPI {
      
      static func fetchPokemonCards(completion: @escaping (Result<[PokemonCard],AppError>) -> ()) {
          let pokemonEndpointURLString = "https://api.pokemontcg.io/v1/cards"
          guard let url = URL(string: pokemonEndpointURLString) else{
              completion(.failure(.badURL(pokemonEndpointURLString)))
              return
          }
          //make a url request object to pass to the networkHelper
          //let request = URLRequest(url: url)
          //set the http method, GET SET, POST
         
          //this is required when posting so we can form the Posst re quest of the data type, if we do not provide the header value as aplication json, we will get a decoding error, when attempting to decode the Json
  //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        NetworkHelper.shared.performDataTask(urlString: pokemonEndpointURLString) { (result) in
              switch result{
              case .failure(let appError):
                  completion(.failure(.networkClientError(appError)))
              case .success(let data):
                  do{
                      //JSONDecoder()- used to convert web data to swift models
                      //JSONEncoder() - used to convert Swift modek to data
                      let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
                    let pokemonCards = pokemonData.cards
                    completion(.success(pokemonCards))
                  } catch {
                      completion(.failure(.decodingError(error)))
                  }
              }
          }
      }
  }

