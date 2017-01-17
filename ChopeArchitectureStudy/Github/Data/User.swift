//
// Created by Chope on 2017. 1. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User: GithubData {
    let id: String
    let login: String
    let gravatarId: String
    let type: String
    let siteAdmin: Bool

    let avatarURL: URL?
    let htmlURL: URL?
    let url: URL?
    let followersURL: URL?
    let followingURL: URL?
    let gistsURL: URL?
    let starredURL: URL?
    let subscriptionsURL: URL?
    let organizationsURL: URL?
    let reposURL: URL?
    let eventsURL: URL?
    let receivedEventsURL: URL?

    init(rawJson: Any) {
        let json = JSON(rawJson)
        id = json["id"].stringValue
        login = json["login"].stringValue
        gravatarId = json["gravatar_id"].stringValue
        type = json["type"].stringValue
        siteAdmin = json["site_admin"].boolValue

        avatarURL = json["avatar_url"].url
        htmlURL = json["html_url"].url
        url = json["url"].url
        followersURL = json["followers_url"].url
        followingURL = json["following_url"].url
        gistsURL = json["gists_url"].url
        starredURL = json["starred_url"].url
        subscriptionsURL = json["subscriptions_url"].url
        organizationsURL = json["organizations_url"].url
        reposURL = json["repos_url"].url
        eventsURL = json["events_url"].url
        receivedEventsURL = json["received_events_url"].url
    }
}