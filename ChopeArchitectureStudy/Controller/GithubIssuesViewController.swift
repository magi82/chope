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

    let model = GithubIssuesModel(user: "Alamofire", repo: "Alamofire")

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80

        NotificationCenter.default.addObserver(self, selector: #selector(onChangedIssues(_:)), name: GithubIssuesModel.ChangedNotification, object: nil)

        model.load()
    }

    override func prepare(`for` segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(`for`: segue, sender: sender)

        guard let identifier = segue.identifier, identifier == "issueDetail",
              let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell),
              let issue: GithubIssue = model.issues[indexPath.row],
              let issueDetailVC = segue.destination as? GithubIssueDetailViewController
        else { return }

        issueDetailVC.issueModel = GithubIssueDetailModel(user: model.user, repo: model.repo, number: issue.number)
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
        issueCell.onTouchedUser = {
            guard let user = issue.user, let url = URL(string: user.githubUrl) else {
                return
            }
            UIApplication.shared.open(url)
        }
        return issueCell
    }
}

extension GithubIssuesViewController: UITableViewDelegate {

}