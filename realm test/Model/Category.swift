//
//  Cateogry.swift
//  realm test
//
//  Created by Asmaa Tarek on 4/21/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
