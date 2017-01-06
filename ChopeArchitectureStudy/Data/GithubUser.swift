//
// Created by Chope on 2017. 1. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class GithubUser: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var avatarUrl = ""
    dynamic var githubUrl = ""

    override class func primaryKey() -> String? {
        return "id"
    }

    convenience init(json jsonObject: [String: AnyObject]) {
        self.init()

        let json = JSON(jsonObject)
        id = json["id"].int ?? 0
        name = json["login"].string ?? ""
        avatarUrl = json["avatar_url"].string ?? ""
        githubUrl = json["html_url"].string ?? ""
    }
}