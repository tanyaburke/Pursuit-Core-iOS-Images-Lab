//
//  UserAPI.swift
//  ImagesLab
//
//  Created by Tanya Burke on 12/14/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import UIKit


struct UserAPI {
  
    static func getUser(comicNumber: Int, completion: @escaping(Result<UserData, AppError>) -> ()) {
        
        let userEndPointUrl = "https://randomuser.me/api/?results=50"
        
        NetworkHelper.shared.performDataTask(urlString: userEndPointUrl){ (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let randomUsers = try JSONDecoder().decode(UserData.self, from: data)
                    completion( .success(randomUsers))
                } catch {
                    completion( .failure(.decodingError(error)))
                }
                
            }
 
        }
        
        
    }
   
    static func userImage(userImage: String, completion: @escaping (Result<UIImage, AppError>) -> ()) {
        
        NetworkHelper.shared.performDataTask(urlString: userImage) { (result) in
            switch result {
            case .failure(let imageError):
                completion(.failure(imageError))
            case .success(let data):
                let imageFromData = UIImage(data: data)
                completion(.success(imageFromData!))
            }
        }
        
    }

}
