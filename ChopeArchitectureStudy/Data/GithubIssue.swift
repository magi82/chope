//
// Created by Chope on 2017. 1. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class GithubIssue: Object {
    dynamic var id = 0
    dynamic var title = ""
    dynamic var body = ""
    dynamic var user: GithubUser?

    override class func primaryKey() -> String? {
        return "id"
    }

    convenience init(json jsonObject: [String: AnyObject]) {
        self.init()

        let json = JSON(jsonObject)
        id = json["id"].int ?? 0
        title = json["title"].string ?? ""
        body = json["body"].string ?? ""

        if let userObject = jsonObject["user"] as? [String: AnyObject] {
            user = GithubUser(json: userObject)
        }
    }
}
