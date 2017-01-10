//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Issue {
    convenience init(githubJson: [String: AnyObject]) {
        self.init()

        let json = JSON(githubJson)
        id = json["id"].stringValue
        number = json["number"].intValue
        title = json["title"].stringValue
        body = json["body"].stringValue

        if let rawUserJson = githubJson["user"] as? [String: AnyObject] {
            user = User(githubJson: rawUserJson)
        }
    }

    convenience init(bitbucketJson: [String: AnyObject]) {
        self.init()

        let json = JSON(bitbucketJson)
        id = json["id"].stringValue
        number = json["id"].intValue
        title = json["title"].stringValue
        body = json["content"]["raw"].stringValue

        if let rawUserJson = bitbucketJson["reporter"] as? [String: AnyObject] {
            user = User(bitbucketJson: rawUserJson)
        }
    }
}

extension User {
    convenience init(githubJson: [String: AnyObject]) {
        self.init()

        let json = JSON(githubJson)
        id = json["id"].stringValue
        name = json["login"].stringValue
        photoUrl = json["avatar_url"].stringValue
        profileUrl = json["html_url"].stringValue
    }

    convenience init(bitbucketJson: [String: AnyObject]) {
        self.init()

        let json = JSON(bitbucketJson)
        id = json["uuid"].stringValue
        name = json["display_name"].stringValue

        photoUrl = json["links"]["avatar"]["href"].stringValue
        profileUrl = json["links"]["html"]["href"].stringValue
    }
}