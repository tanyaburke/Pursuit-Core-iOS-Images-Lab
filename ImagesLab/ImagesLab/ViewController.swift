//
//  ViewController.swift
//  ImagesLab
//
//  Created by Tanya Burke on 12/9/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var stepperControl: UIStepper!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var mostRecent: UIButton!
    
    @IBOutlet weak var randomEpisode: UIButton!
    
    
    
    
    var currentComic = 0 {
        didSet{
            setNonStaticStepperValue()
            //loadImage()
            loadData()
            
        }
    }
  var comic = Comic(month: "11", year: "2019", img: "", title: "", num: 2240)//changed num  then it worked

    
    override func viewDidLoad() {
        super.viewDidLoad()
          setStaticStepperValue()
                loadData()
               //loadImage()
        textField.delegate = self
    }

    
   
    func loadData(){
        ComicAPI .getComic(comicNumber: currentComic) { [weak self](result) in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async {
                   self?.showAlert(title: "Error Message", message: "\(appError)")
                }
                
            case.success(let comic):
                self?.comic = comic
                self?.loadImage()
            }
            
        }
    }
    
    func loadImage(){
        //print(comic.img)
            ComicAPI.comicImage(comicImage: comic.img, completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "No Image", message: "\(appError)")
                    self?.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                }
                
            case .success(let image):
                DispatchQueue.main.async {
                  self?.imageView.image = image
                }
                
            }
        })
    }
    
    
    
    func setStaticStepperValue(){
        stepperControl.maximumValue = Double(comic.num)
        
        stepperControl.minimumValue = 1.0
    }
    
    func setNonStaticStepperValue(){
        stepperControl.value = Double(currentComic)//

    }
    
    
    
    
    
    @IBAction func stepperValue(sender: UIStepper) {
        currentComic = Int(sender.value)
        
        
    }
    
    @IBAction func mostRecentComic(sender: UIButton){
        currentComic = 0
     
    }
    
    @IBAction func randomComic(sender: UIButton){
     //comic.num should be stored in variable that stores the maximum value
        currentComic = Int.random(in: 0...comic.num)//
    }


}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let enteredText = textField.text else {
            return false
        }
        for char in enteredText{
            if !char.isNumber{
                return false
            }
            
        }
        
        //print("before" , enteredText)
        currentComic = Int(enteredText) ?? 0
        //print("after", enteredText)
        textField.text = ""
        textField.resignFirstResponder()
    
        return true
    }
    
}



