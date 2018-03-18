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
    let defaults = UserDefaults.standard
    let arrayKey = "ToDoListArray"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem = Items()
        newItem.title = "Ricardo Kaka"
        itemArray.append(newItem)
        
        let newItem1 = Items()
        newItem1.title = "Lio Messi"
        itemArray.append(newItem1)
        
        let newItems2 = Items()
        newItems2.title = "Steven Gerrard"
        itemArray.append(newItems2)
        
        
        if let items = defaults.array(forKey: arrayKey) as? [Items]{
            itemArray = items
        }
        
        
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
        
        tableView.reloadData()
        
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
            self.defaults.set(self.itemArray, forKey: self.arrayKey)
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertText) in
            alertText.placeholder = "Save new item"
            textField = alertText
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    


}

