//
//  ViewController.swift
//  API DEMO
//
//  Created by Сергей Голенко on 28.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
   
    
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    
  
    
    @IBAction func submit(_ sender: Any) {
        if let url = URL(string:
                            "http://api.openweathermap.org/data/2.5/weather?q="+cityTextField.text!+"&appid=358a1c0e3636815b8188f88a194581b6"){
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("ERROR - \(error)")
                } else {
                    if let content = data {
                        do{
                            let jsonResult = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                           
                            print(jsonResult!["name"])
                            
                            if let discription = jsonResult!["weather"]as?NSArray
                            {
                                if let discription2 = discription[0]as?NSDictionary{
                                    if let discription3 = discription2["description"]as?String{
                                        print(discription3)
                                        DispatchQueue.main.sync(execute: {
                                            self.resultLabel.text = discription3
                                        })
                                    }
                                }
                            }
                        } catch {
                            print("JSON Processing Failed")
                        }
                    }
                }
            }
            task.resume()
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }

}

