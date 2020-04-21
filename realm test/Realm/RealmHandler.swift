//
//  RealmHandler.swift
//  realm test
//
//  Created by Asmaa Tarek on 4/21/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHandler {
    public static let instance = RealmHandler()
    private  let realm = try? Realm()

    private init(){
    }
    
      func saveCatIntoRealm(category: Category){
        do{
            try realm?.write({
                realm?.add(category)
            })
        }catch{
            print("can't save category")
        }
    }
    func readCatFromRealm() -> Results<Category>? {
        
        return realm?.objects(Category.self)
    }
    
    func deleteCategory(category: Category){
        do{
            try realm?.write({
                realm?.delete(category)
            })
        }catch{
            print("can't delete category")
        }
    }

    func saveItemsIntoRealm(currentCategory: Category, item: Item)  {
        do{
            try realm?.write({
                            currentCategory.items.append(item)
            })
        }catch{
            print("Error in save items")
        }
    }
    
    func changeDoneStatus(item: Item){
       do{
            try realm?.write({
                item.done = !item.done
            })
        }catch{
            print("Error in save items")
        }
    }
    func deletItem(item: Item){
           do{
               try realm?.write({
                   realm?.delete(item)
               })
           }catch{
               print("can't delete item")
           }
       }
}
