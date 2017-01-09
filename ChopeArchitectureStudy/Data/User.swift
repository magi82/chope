//
// Created by Chope on 2017. 1. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class User: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var photoUrl = ""
    dynamic var profileUrl = ""

    override class func primaryKey() -> String? {
        return "id"
    }

    convenience init(json jsonObject: [String: AnyObject]) {
        self.init()

        let json = JSON(jsonObject)
        id = json["id"].int ?? 0
        name = json["login"].string ?? ""
        photoUrl = json["avatar_url"].string ?? ""
        profileUrl = json["html_url"].string ?? ""
    }
}