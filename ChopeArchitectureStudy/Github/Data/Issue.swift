//
// Created by Chope on 2017. 1. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import SwiftyJSON

struct Issue: GithubData {
    let id: Int
    let number: Int
    let title: String
    let body: String
    let state: String
    let isLocked: Bool
    let comments: Int

    let user: User?
    let assignee: User?
    let milestone: Milestone?
    let pullRequest: PullRequest?
    let labels: [Label]

    let closedAt: String?
    let createdAt: String?
    let updatedAt: String?

    let url: URL?
    let repositoryURL: URL?
    let labelsURL: URL?
    let commentsURL: URL?
    let eventsURL: URL?
    let htmlURL: URL?

    init(rawJson: Any) {
        let json = JSON(rawJson)
        id = json["id"].intValue
        number = json["number"].intValue
        title = json["title"].stringValue
        body = json["body"].stringValue
        state = json["state"].stringValue
        isLocked = json["locked"].boolValue
        comments = json["comments"].intValue

        user = User(rawJson: json["user"].dictionaryValue)
        assignee = User(rawJson: json["assignee"].dictionaryValue)
        milestone = Milestone(rawJson: json["milestone"].dictionaryValue)
        pullRequest = PullRequest(rawJson: json["pull_request"].dictionaryValue)

        let rawLabels = json["labels"].arrayValue
        var labels: [Label] = []
        rawLabels.forEach { rawJson in
            labels.append(Label(rawJson: rawJson))
        }
        self.labels = labels

        closedAt = json["closed_at"].stringValue
        createdAt = json["created_at"].stringValue
        updatedAt = json["updated_at"].stringValue

        url = json["url"].url
        repositoryURL = json["repository_url"].url
        labelsURL = json["labels_url"].url
        commentsURL = json["comments_url"].url
        eventsURL = json["events_url"].url
        htmlURL = json["html_url"].url
    }
}
