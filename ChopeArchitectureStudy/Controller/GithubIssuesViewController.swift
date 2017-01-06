//
//  GithubIssuesViewController.swift
//  ChopeArchitectureStudy
//
//  Created by Chope on 2017. 1. 5..
//  Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit


class GithubIssuesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    let model = GithubIssueModel(user: "JakeWharton", repo: "DiskLruCache")

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80

        NotificationCenter.default.addObserver(self, selector: #selector(onChangedIssues(_:)), name: GithubIssuesChangedNotification, object: nil)

        model.load()
    }

    func onChangedIssues(_ notification: Notification) {
        tableView.reloadData()
    }
}

extension GithubIssuesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.issues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let issueCell = tableView.dequeueReusableCell(withIdentifier: "issue", for: indexPath) as? IssueTableViewCell else {
            assertionFailure()
            return UITableViewCell()
        }
        let issue: GithubIssue = model.issues[indexPath.row]
        issueCell.title = issue.title
        issueCell.id = issue.number
        issueCell.username = issue.user?.name
        issueCell.userImageURL = URL(string: issue.user?.avatarUrl ?? "")
        return issueCell
    }
}

extension GithubIssuesViewController: UITableViewDelegate {

}