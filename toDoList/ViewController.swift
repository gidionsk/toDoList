//
//  ViewController.swift
//  toDoList
//
//  Created by Gidion S on 16/06/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var userDefaults = UserDefaults.standard
    var tempData:[dataStruct] = []
    
    @IBOutlet weak var dataTv: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let strings = UserDefaults.standard.data(forKey: "data")
//        let strings = userDefaults.object(forKey: "data") as? [dataStruct]
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        
        cell.textLabel?.text = tempData[indexPath.row].title
        cell.detailTextLabel?.text = tempData[indexPath.row].subtitle
   
        return cell
        
    }
    
    var indeks = 0;
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Delete") { [weak self] (action, view, completionHandler) in
                                            self?.handleMarkAsFavourite()
                                            completionHandler(true)
        }
        indeks = indexPath.row
        action.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    private func handleMarkAsFavourite() {
        self.tempData.remove(at: indeks)
        let encoder = PropertyListEncoder()
        
        if let encoded = try? encoder.encode(tempData) {
            userDefaults.set(encoded, forKey: "data")
           
        }
        dataTv.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(indexPath.row)
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataTv.dataSource = self
        dataTv.delegate = self
        if let savedData = userDefaults.value(forKey: "data") as? Data {
            let loadedData = try? PropertyListDecoder().decode(Array<dataStruct>.self, from: savedData)
            tempData = loadedData!
            
        }

        // Do any additional setup after loading the view.
    }
    
    


    @IBAction func addAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController2")
       self.navigationController?.pushViewController(vc, animated: true)
    }
}

