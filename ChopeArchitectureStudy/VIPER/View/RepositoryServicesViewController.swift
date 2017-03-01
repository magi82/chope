//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import CPGithub

class RepositoryServicesViewController: UIViewController {
    var presenter: RepositoryServicesPresenter!

    @IBOutlet fileprivate weak var githubAccessTokenTextField: UITextField!
    @IBOutlet fileprivate weak var githubUsernameTextField: UITextField!
    @IBOutlet fileprivate weak var githubRepoTextField: UITextField!
    @IBOutlet private weak var githubIssuesButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(presenter != nil)

        presenter.view = self
    }

    @IBAction func touchGithubIssues() {
        guard let username = githubUsernameTextField.text,
              let repo = githubRepoTextField.text,
              let accessToken = githubAccessTokenTextField.text
        else { return }
        presenter.changed(accessToken: accessToken)
        presenter.touchedIssues(username: username, repo: repo)
    }
}

extension RepositoryServicesViewController: RepositoryServicesView {
    func set(accessToken: String?) {
        githubAccessTokenTextField?.text = accessToken
    }

    func set(username: String?) {
        githubUsernameTextField?.text = username
    }

    func set(repo: String?) {
        githubRepoTextField?.text = repo
    }
}