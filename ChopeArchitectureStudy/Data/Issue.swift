//
// Created by Chope on 2017. 1. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Issue: Object {
    dynamic var id = ""
    dynamic var number = 0
    dynamic var title = ""
    dynamic var body = ""
    dynamic var user: User?

    override class func primaryKey() -> String? {
        return "id"
    }
}
