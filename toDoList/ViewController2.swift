//
//  ViewController2.swift
//  toDoList
//
//  Created by Gidion S on 16/06/22.
//

import Foundation
import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var subtitleText: UITextField!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var taskText: UITextView!
    @IBOutlet weak var createButton: UIButton!
    var dataItem:[dataStruct] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        taskText.layer.borderColor = UIColor.black.cgColor
        taskText.layer.borderWidth = 1
        // Do any additional setup after loading the view.
    }
    
    var userDefaults = UserDefaults.standard
    
    @IBAction func createAction(_ sender: Any) {
        let titleTxt = titleText.text ?? ""
        let subtitleTxt = subtitleText.text ?? ""
        let taskTxt = taskText.text ?? ""
        
        
        if titleTxt == ""{
            let dialogMessage = UIAlertController(title: "Attention", message: "Title must be filled", preferredStyle: .alert)

            let ok = UIAlertAction(title:"OK",style: .default, handler: {(action)-> Void in
                print("OK")
            })
            
            let cancel = UIAlertAction(title:"Cancel", style: .cancel){
                (action) -> Void in
                print("Canceled")
            }
            
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)
            
            self.present(dialogMessage,animated: true, completion: nil)
        }
        else if subtitleTxt == ""{
            let dialogMessage = UIAlertController(title: "Attention", message: "Subtitle must be filled", preferredStyle: .alert)

            let ok = UIAlertAction(title:"OK",style: .default, handler: {(action)-> Void in
                print("OK")
            })
            
            let cancel = UIAlertAction(title:"Cancel", style: .cancel){
                (action) -> Void in
                print("Canceled")
            }
            
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)
            
            self.present(dialogMessage,animated: true, completion: nil)
        }else{
            if let savedData = userDefaults.value(forKey: "data") as? Data {
                let loadedData = try? PropertyListDecoder().decode(Array<dataStruct>.self, from: savedData)
                dataItem = loadedData!
                
            }

            dataItem.append(dataStruct(title: titleTxt, subtitle: subtitleTxt, task: taskTxt))
            print(dataItem)
            let encoder = PropertyListEncoder()
            
            if let encoded = try? encoder.encode(dataItem) {
                userDefaults.set(encoded, forKey: "data")
               
            }
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
           self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

struct dataStruct: Codable{
    var title:String
    var subtitle:String
    var task:String
}

