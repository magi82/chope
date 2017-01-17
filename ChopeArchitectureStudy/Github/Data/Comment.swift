//
// Created by Chope on 2017. 1. 15..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Comment: GithubData {
    let id: Int
    let body: String
    let user: User?

    let createdAt: String
    let updatedAt: String

    let url: URL?
    let htmlURL: URL?

    init(rawJson: Any) {
        let json = JSON(rawJson)
        id = json["id"].intValue
        url = json["url"].url
        htmlURL = json["url"].url
        body = json["body"].stringValue
        createdAt = json["created_at"].stringValue
        updatedAt = json["updated_at"].stringValue

        user = User(rawJson: json["user"].dictionaryValue)
    }
}
