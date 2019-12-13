//
//  ComicAPI.swift
//  ImagesLab
//
//  Created by Tanya Burke on 12/10/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import Foundation
import UIKit

struct ComicAPI {
    static func getComic(comicNumber: Int, completion: @escaping(Result<Comic, AppError>) -> ()) {
        var str = "0"
        if str == String(comicNumber) {
            str = ""
        } else {
            str = String(comicNumber)
        }
        let comicEndPointUrl = "https://xkcd.com/\(str)/info.0.json"
        
        
        

        NetworkHelper.shared.performDataTask(urlString: comicEndPointUrl){ (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode(Comic.self, from: data)
                    completion( .success(searchResults))
                } catch {
                    completion( .failure(.decodingError(error)))
                }
                
            }
 
        }
        
        
    }
   
    static func comicImage(comicImage: String, completion: @escaping (Result<UIImage, AppError>) -> ()) {
        
        NetworkHelper.shared.performDataTask(urlString: comicImage) { (result) in
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
