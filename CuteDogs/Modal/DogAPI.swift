//
//  DogAPI.swift
//  CuteDogs
//
//  Created by Kavya Joshi on 7/20/21.
//

import Foundation
import UIKit

struct DogAPI
{
//I can make enum either rawValues(when all the values have same type.) or
    // can make it Associative type to handle different cases from API.
    static let breeds = ["bloodhound", "akita", "collie", "newfoundland", "maltese", "chihuahua" ,"pug", "vizsla", "mastiff", "brittany", "havanese", "labrador", "husky", "dachshund" , "shiba", "boxer", "rottweiler", "poodle", "bulldog", "retriever", "germanshepherd" ,"greyhound", "malamute","samoyed"]
  
    enum API {
        case randomImageAPI
        case byBreedAPI(String)
        
        var url : URL?{
            URL(string: self.stringValue)
        }
        
     //set string value for each case accordingly(Associative enum Values)
        var stringValue : String
        {
            switch self{
            case .randomImageAPI : return "https://dog.ceo/api/breeds/image/random"
            case .byBreedAPI(let breed) :
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            }
        }
        
    }
    
static func fetchDogImageURLFrom(url : URL , completionHandler : @escaping
                                        (String?, Error? )  -> Void)
    {
        let mySession = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { print("We didn't get the data")
                //In case of error, return Error to the main function
                completionHandler(nil,error)
                return
            }
            
            if error == nil {
                //fetch data through JSON codable format
             
                let decorder = JSONDecoder()
       
                do
             {
              let  myData = (try decorder.decode(randomDog.self, from: data)).message
                
                print(myData)
                
                completionHandler(myData,nil)
                return
             }

             
                catch let error as NSError {
                    print("Error Description: \(error.description)")
                    print("Error domain: \(error.domain)")
                    print("Error code: \(error.code)")
                    print("Error userInfo: \(error.userInfo)")
                                             }

                
                }
        }
        
        mySession.resume()
        
    }
    
    static func downloadImageFrom(url : String, completionHandler : @escaping (Error?, UIImage?) -> Void)
    {
        
            let myURL = URL(string: url)
                guard let myURL = myURL else {
                    return
                }
    let mySession = URLSession.shared.dataTask(with: myURL) { data, response, error in
        if error != nil{
            print("unable to download")
            print(error!.localizedDescription)
            completionHandler(error,nil)
            return
        }
        print("**************")
        let image = UIImage(data: data!)
        if let image = image{
            completionHandler(nil,image)
            return
        }
        
    }
            
           //  myImage = UIImage(data: data)
    mySession.resume()
    return
 
}


}
//MARK: - JSON object to be fetched

//{"message": "https://images.dog.ceo/breeds/terrier-fox/n02095314_2876.jpg","status": "success"}

struct randomDog : Codable{
    let message: String
    let status: String
    
}
