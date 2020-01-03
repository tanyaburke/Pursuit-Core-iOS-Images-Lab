//
//  ViewController + extension.swift
//  ImagesLab
//
//  Created by Tanya Burke on 12/12/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String ){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
    }
}
