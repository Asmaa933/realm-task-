//
//  ViewController.swift
//  realm test
//
//  Created by Asmaa Tarek on 4/18/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private var categories: Results<Category>?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        categories = RealmHandler.instance.readCatFromRealm()
        tableView.reloadData()
    }
    
    @IBAction private func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) {[weak self](action) in
            guard let self = self else {return}
            guard let text = textField.text else {return}
            let newCategory = Category()
            newCategory.name = text
            if(!text.isEmpty){
                RealmHandler.instance.saveCatIntoRealm(category: newCategory)
                self.tableView.reloadData()
            }
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add new category"
        }
        present(alert, animated: true, completion: nil)
    }
    
}
extension CategoryViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ItemsTableViewController else {return}
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        destination.selectedCategory = categories?[indexPath.row]
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            guard let category = categories?[indexPath.row] else {return}
            RealmHandler.instance.deleteCategory(category: category)
            tableView.reloadData()
        }
    }
}
