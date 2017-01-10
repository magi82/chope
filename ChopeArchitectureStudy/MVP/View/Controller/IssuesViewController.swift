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

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80

        assert(presenter != nil)
        presenter.view = self
        presenter.issues()
    }

    override func prepare(`for` segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        guard let identifier = segue.identifier, identifier == "issueDetail",
              let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell),
              let issueDetailVC = segue.destination as? IssueDetailViewController
        else { return }

        issueDetailVC.presenter = presenter.detailPresenter(index: indexPath.row)
    }
}

extension IssuesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let issueCell = tableView.dequeueReusableCell(withIdentifier: "issue", for: indexPath) as? IssueTableViewCell else {
            assertionFailure()
            return UITableViewCell()
        }

        let issue = issues[indexPath.row]
        presenter.display(issue: issue, inView: issueCell)
        issueCell.onTouchedUser = { [weak self] in
            self?.presenter.touchUserPhoto(atIndex: indexPath.row)
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

    func open(url: URL) {
        UIApplication.shared.open(url)
    }
}