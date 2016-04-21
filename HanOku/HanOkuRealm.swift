//
//  HanOkuRealm.swift
//  HanOku
//
//  Created by tlsmooth89 on 4/21/16.
//  Copyright © 2016 yusuke.iwasaki. All rights reserved.
//

import RealmSwift

class Item: Object {
    
    dynamic var id = 0
    dynamic var title = ""
    dynamic var detail = ""
    
    // Setting "id" as the primary key
    override static func primaryKey() -> String? {
        return "id"
    }
}