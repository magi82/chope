//
// Created by Chope on 2017. 2. 9..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Repo: GithubData {
    let id: Int64
    let owner: User
    let name: String
    let fullName: String
    let description: String
    let `private`: Bool
    let fork: Bool
//    let language: String?
    let forksCount: Int
    let stargazersCount: Int
    let watchersCount: Int
    let size: Int
    let defaultBranch: String
    let openIssuesCount: Int
    let hasIssues: Bool
    let hasWiki: Bool
    let hasPages: Bool
    let hasDownloads: Bool

    let url: URL?
    let htmlURL: URL?
    let archiveURL: URL?
    let assigneesURL: URL?
    let blobsURL: URL?
    let branchesURL: URL?
    let cloneURL: URL?
    let collaboratorsURL: URL?
    let commentsURL: URL?
    let commitsURL: URL?
    let compareURL: URL?
    let contentsURL: URL?
    let contributorsURL: URL?
    let deploymentsURL: URL?
    let downloadsURL: URL?
    let eventsURL: URL?
    let forksURL: URL?
    let gitCommitsURL: URL?
    let gitRefsURL: URL?
    let gitTagsURL: URL?
    let gitURL: URL?
    let hooksURL: URL?
    let issueCommentURL: URL?
    let issueEventsURL: URL?
    let issuesURL: URL?
    let keysURL: URL?
    let labelsURL: URL?
    let languagesURL: URL?
    let mergesURL: URL?
    let milestonesURL: URL?
    let mirrorURL: URL?
    let notificationsURL: URL?
    let pullsURL: URL?
    let releasesURL: URL?
    let sshURL: URL?
    let stargazersURL: URL?
    let statusesURL: URL?
    let subscribersURL: URL?
    let subscriptionURL: URL?
    let svnURL: URL?
    let tagsURL: URL?
    let teamsURL: URL?
    let treesURL: URL?
    let homepage: URL?
    
    let pushedAt: Date?
    let createdAt: Date?
    let updatedAt: Date?

    init(rawJson: Any) {
        let json = JSON(rawJson)
        id = json["id"].int64Value
        owner = User(rawJson: json["owner"])
        name = json["name"].stringValue
        fullName = json["full_name"].stringValue
        description = json["description"].stringValue
        `private` = json[""].boolValue
        fork = json["fork"].boolValue
        forksCount = json["forks_count"].intValue
        stargazersCount = json["stargazers_count"].intValue
        watchersCount = json["watchers_count"].intValue
        size = json["size"].intValue
        defaultBranch = json["default_branch"].stringValue
        openIssuesCount = json["open_issues_count"].intValue
        hasIssues = json["has_issues"].boolValue
        hasWiki = json["has_wiki"].boolValue
        hasPages = json["has_pages"].boolValue
        hasDownloads = json["has_downloads"].boolValue

        url = json["_url"].url
        htmlURL = json["html_url"].url
        archiveURL = json["archive_url"].url
        assigneesURL = json["assignees_url"].url
        blobsURL = json["blobs_url"].url
        branchesURL = json["branches_url"].url
        cloneURL = json["clone_url"].url
        collaboratorsURL = json["collaborators_url"].url
        commentsURL = json["comments_url"].url
        commitsURL = json["commits_url"].url
        compareURL = json["compare_url"].url
        contentsURL = json["contents_url"].url
        contributorsURL = json["contributors_url"].url
        deploymentsURL = json["deployments_url"].url
        downloadsURL = json["downloads_url"].url
        eventsURL = json["events_url"].url
        forksURL = json["forks_url"].url
        gitCommitsURL = json["git_commits_url"].url
        gitRefsURL = json["git_refs_url"].url
        gitTagsURL = json["git_tags_url"].url
        gitURL = json["git_url"].url
        hooksURL = json["hooks_url"].url
        issueCommentURL = json["issue_comment_url"].url
        issueEventsURL = json["issue_events_url"].url
        issuesURL = json["issues_url"].url
        keysURL = json["keys_url"].url
        labelsURL = json["labels_url"].url
        languagesURL = json["languages_url"].url
        mergesURL = json["merges_url"].url
        milestonesURL = json["milestones_url"].url
        mirrorURL = json["mirror_url"].url
        notificationsURL = json["notifications_url"].url
        pullsURL = json["pulls_url"].url
        releasesURL = json["releases_url"].url
        sshURL = json["ssh_url"].url
        stargazersURL = json["stargazers_url"].url
        statusesURL = json["statuses_url"].url
        subscribersURL = json["subscribers_url"].url
        subscriptionURL = json["subscription_url"].url
        svnURL = json["svn_url"].url
        tagsURL = json["tags_url"].url
        teamsURL = json["teams_url"].url
        treesURL = json["trees_url"].url
        homepage = json["homepage"].url

        pushedAt = json["pushed_at"].date
        createdAt = json["created_at"].date
        updatedAt = json["updated_at"].date
    }

}
