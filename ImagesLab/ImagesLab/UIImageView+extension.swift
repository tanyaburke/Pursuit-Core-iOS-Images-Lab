//
//  UIImageView+extension.swift
//  ImagesLab
//
//  Created by Tanya Burke on 12/10/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import UIKit

extension UIImageView {
    
    //instance method
    func getImage(with urlString: String, completion: @escaping (Result<UIImage, AppError>) ->()){
        
        //configure UIActivityIndicatorView
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .orange
        activityIndicator.center = center //center of cell
        addSubview(activityIndicator) //adds to subview
        activityIndicator.startAnimating()
      
        //what thread
        //update UI

        
        //singleton-shared/default/main that gives us access to it
        NetworkHelper.shared.performDataTask(urlString: urlString) { [weak activityIndicator](result) in
            DispatchQueue.main.async {
                activityIndicator?.stopAnimating()
            }
            switch result {
            case .failure (let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                let image = UIImage(data: data)
                completion(.success(image!))
            }
        }
    }

//
//static func comicImage(comicImage: String, completion: @escaping (Result<UIImage, AppError>) -> ()) {
//
//    NetworkHelper.shared.performDataTask(urlString: comicImage) { (result) in
//        switch result {
//        case .failure(let imageError):
//            completion(.failure(imageError))
//        case .success(let data):
//            let imageFromData = UIImage(data: data)
//            completion(.success(imageFromData!))
//        }
//    }
//
//}

}
