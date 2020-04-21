//
//  ItemsTableViewController.swift
//  realm test
//
//  Created by Asmaa Tarek on 4/21/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import UIKit
import RealmSwift

class ItemsTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    var itemArr: Results<Item>?
    var selectedCategory: Category?{
        didSet{
            loadItems()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
    }
    
    
    func loadItems(){
        itemArr = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { [weak self] (action) in
            guard let self = self else {return}
            guard let currentCategory = self.selectedCategory else {return}
            let newItem = Item()
            newItem.title = textField.text ?? ""
            newItem.dateCreated = Date()
            RealmHandler.instance.saveItemsIntoRealm(currentCategory: currentCategory, item: newItem)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add Item"
        }
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArr?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        guard let item = itemArr?[indexPath.row] else {return UITableViewCell()}
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done  ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = itemArr?[indexPath.row] else {return}
        RealmHandler.instance.changeDoneStatus(item: item)
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            guard let item = itemArr?[indexPath.row] else {return}
            RealmHandler.instance.deletItem(item: item )
            tableView.reloadData()
            
        }
    }
    
}
extension ItemsTableViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
        }else{
            itemArr = itemArr?.filter("title CONTAINS[cd] %@", searchBar.text ?? "").sorted(byKeyPath: "dateCreated", ascending: true)
            
            tableView.reloadData()
        }
        itemArr = itemArr?.filter("title CONTAINS[cd] %@", searchBar.text ?? "").sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
        
    }
  
    
}
