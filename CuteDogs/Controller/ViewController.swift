//
//  ViewController.swift
//  CuteDogs
//
//  Created by Kavya Joshi on 7/20/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var dogImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    func ImageLoadingStart(breed : String)

        //As the user clicks the load button,
        //1 Start making network request to dog API for the images
        //The Dog API: https://dog.ceo/dog-api/
    {

        //a) Create a URL
        print("Networking started")
        
        //b) Create a URL Session
        guard let myRandomDogURL = DogAPI.API.byBreedAPI(breed).url else  { print("Something wrong with URL")
            return}
        
        //Calling Modal method
        DogAPI.fetchDogImageURLFrom(url: myRandomDogURL,completionHandler: handleImageURl(imageUrlString:error:))
    }
    
    func handleImageURl(imageUrlString: String?, error :Error?)
    {
        if error != nil{
            print(error!.localizedDescription)
        }
        if let imageUrl = imageUrlString{
            DogAPI.downloadImageFrom(url: imageUrl,completionHandler: handleImageFile(error:downloadedImage:))
        }
    }
    
    
    func handleImageFile(error : Error? , downloadedImage : UIImage?)
    {
        if error != nil
        {
            print("cannot download")
            return
        }
        DispatchQueue.main.async {
            self.dogImage.image = downloadedImage
        }
    }
}

extension ViewController : UIPickerViewDataSource, UIPickerViewDelegate
{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        DogAPI.breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        DogAPI.breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ImageLoadingStart(breed:  DogAPI.breeds[row])
    }
    
    
}
