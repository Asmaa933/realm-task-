//
//  Item.swift
//  realm test
//
//  Created by Asmaa Tarek on 4/21/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategoty = LinkingObjects(fromType: Category.self, property: "items")
}
