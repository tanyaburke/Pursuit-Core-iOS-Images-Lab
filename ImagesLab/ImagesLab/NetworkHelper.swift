//
//  NetworkHelper.swift
//  ImagesLab
//
//  Created by Tanya Burke on 12/10/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import Foundation

class NetworkHelper {
  // we will create a shared instance of the NetworkHelper
  static let shared = NetworkHelper()
  
  private var session: URLSession
  
  // we will make the default initializer private
  // required in order to be considered a singleton
  // also forbids anyone from creating an instance of NetworkHelper
  private init() {
    session = URLSession(configuration: .default)
  }
  
  func performDataTask(urlString: String,
                       completion: @escaping (Result<Data, AppError>) -> ()) {
    // two states on dataTask, resume() and suspended by default
    // suspended simply won't perform network request
    // this ultimately leads to debugging errors and time lost if
    // you don't explicitly resume() request
    
    guard let url = URL(string: urlString) else {
        completion(.failure(.badURL(urlString)))
        return
    }
    
    let dataTask = session.dataTask(with: url) { (data, response, error) in
      
      // 1. deal with error if any
      // check for client network errors
      if let error = error {
        completion(.failure(.networkClientError(error)))
      }
      
      // 2. downcast URLResponse (response) to HTTPURLResponse to
      //    get access to the statusCode property on HTTPURLResponse
      guard let urlResponse = response as? HTTPURLResponse else {
        completion(.failure(.noResponse))
        return
      }
      
      // 3. unwrap the data object
      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      
      // 4. validate that the status code is in the 200 range otherwise it's a
      //    bad status code
      switch urlResponse.statusCode {
      case 200...299: break // everything went well here
      default:
        completion(.failure(.badStatusCode(urlResponse.statusCode)))
        return
      }
      
      // 5. capture data as success case
      completion(.success(data))
    }
    dataTask.resume()
  }
}
