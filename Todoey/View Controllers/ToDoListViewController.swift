//
//  ViewController.swift
//  Todoey
//
//  Created by Rahul Avale on 3/17/18.
//  Copyright © 2018 Rahul Avale. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Items]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let arrayKey = "ToDoListArray"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        print(dataFilePath)
        
       loadDataUsingNSDecoder()
        
        
//        if let items = defaults.array(forKey: arrayKey) as? [Items]{
//            itemArray = items
//        }
        
        
    }

    //TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //TableView Datadelegate Methodes
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveDataUsingNSCoder()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Add New Items
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newItem = Items()
            if let newValue = textField.text {
                newItem.title = newValue
            }
            self.itemArray.append(newItem)
            
            self.saveDataUsingNSCoder()
            
        }
        
        alert.addTextField { (alertText) in
            alertText.placeholder = "Save new item"
            textField = alertText
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveDataUsingNSCoder () {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array : \(error)")
        }
        tableView.reloadData()
        
    }
    
    func loadDataUsingNSDecoder() {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Items].self, from: data)
            } catch {
                print("Error while decoding data : \(error)")
            }
        }
    }
    


}

