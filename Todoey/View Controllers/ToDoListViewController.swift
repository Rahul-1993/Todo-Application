//branch from master created
//
//  ViewController.swift
//  Todoey
//
//  Created by Rahul Avale on 3/17/18.
//  Copyright © 2018 Rahul Avale. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController, UISearchBarDelegate {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let arrayKey = "ToDoListArray"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
//        print(dataFilePath)
        
       loadData()
        
        
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
        
        saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Add New Items
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newItem = Item(context: self.context)
            if let newValue = textField.text {
                newItem.title = newValue
                newItem.done = false
            }
            self.itemArray.append(newItem)
            
            self.saveData()
            
        }
        
        alert.addTextField { (alertText) in
            alertText.placeholder = "Save new item"
            textField = alertText
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveData () {
        do {
            try context.save()
        } catch {
            print("Error saving context : \(error)")
        }
        tableView.reloadData()
        
    }
    
    func loadData() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)

        } catch {
            print("Error : \(error)")
        }
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        
//    }


}

