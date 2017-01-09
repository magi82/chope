//
//  IssuesViewController.swift
//  ChopeArchitectureStudy
//
//  Created by Chope on 2017. 1. 5..
//  Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit


class IssuesViewController: UIViewController {
    var presenter: IssuesPresenter!

    @IBOutlet private weak var tableView: UITableView!

    fileprivate var issues: [Issue] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if presenter == nil {
            presenter = IssuesPresenter(model: GithubIssuesModel(user: "Alamofire", repo: "Alamofire"), view: self)
        }
        assert(presenter != nil)

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80

        presenter.issues()
    }

    override func prepare(`for` segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(`for`: segue, sender: sender)

        guard let identifier = segue.identifier, identifier == "issueDetail",
              let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell),
              let issue: Issue = issues[indexPath.row],
              let issueDetailVC = segue.destination as? IssueDetailViewController
        else { return }

//        issueDetailVC.issueModel = GithubIssueDetailModel(user: model.user, repo: model.repo, number: issue.number)
    }
}

extension IssuesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let issueCell = tableView.dequeueReusableCell(withIdentifier: "issue", for: indexPath) as? IssueTableViewCell,
              let cellView = issueCell as? IssuesCellView
        else {
            assertionFailure()
            return UITableViewCell()
        }

        let issue = issues[indexPath.row]
        presenter.display(issue: issue, inView: cellView)
        issueCell.onTouchedUser = {
            guard let user = issue.user, let url = URL(string: user.profileUrl) else {
                return
            }
            UIApplication.shared.open(url)
        }
        return issueCell
    }
}

extension IssuesViewController: UITableViewDelegate {

}

extension IssuesViewController: IssuesView {
    func set(issues: [Issue]) {
        self.issues = issues
    }
}