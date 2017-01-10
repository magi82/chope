//
// Created by Chope on 2017. 1. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class User: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var photoUrl = ""
    dynamic var profileUrl = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}