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
    let name: String
    let company: String
    let location: String
    let email: String
    let hireable: Bool
    let bio: String
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int

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
    let blog: URL?

    let createAt: Date?
    let updateAt: Date?

    init(rawJson: Any) {
        let json = JSON(rawJson)
        id = json["id"].stringValue
        login = json["login"].stringValue
        gravatarId = json["gravatar_id"].stringValue
        type = json["type"].stringValue
        siteAdmin = json["site_admin"].boolValue
        name = json["name"].stringValue
        company = json["company"].stringValue
        location = json["location"].stringValue
        email = json["email"].stringValue
        hireable = json["hireable"].boolValue
        bio = json["bio"].stringValue
        publicRepos = json["public_repos"].intValue
        publicGists = json["public_gists"].intValue
        followers = json["followers"].intValue
        following = json["following"].intValue

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
        blog = json["blog"].url

        createAt = json["created_at"].date
        updateAt = json["updated_at"].date
    }
}