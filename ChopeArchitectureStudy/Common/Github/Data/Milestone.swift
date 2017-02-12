//
// Created by Chope on 2017. 1. 17..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Milestone: GithubData {
    let id: Int
    let number: Int
    let state: String
    let title: String
    let description: String
    let creator: User?
    let openIssues: Int
    let closedIssues: Int

    let url: URL?
    let htmlURL: URL?
    let labelsURL: URL?

    let createdAt: String
    let updatedAt: String
    let closedAt: String
    let dueOn: String

    init(rawJson: Any) {
        let json = JSON(rawJson)
        id = json["id"].intValue
        number = json["number"].intValue
        state = json["state"].stringValue
        title = json["title"].stringValue
        description = json["description"].stringValue
        openIssues = json["open_issues"].intValue
        closedIssues = json["closed_issues"].intValue

        creator = User(rawJson: json["creator"])

        url = json["url"].url
        htmlURL = json["html_url"].url
        labelsURL = json["labels_url"].url

        createdAt = json["created_at"].stringValue
        updatedAt = json["updated_at"].stringValue
        closedAt = json["closed_at"].stringValue
        dueOn = json["due_on"].stringValue
    }
}
