//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import CPGithub

class RepositoryServicesViewController: UIViewController {
    let viewModel = RepositoryServicesViewModel()

    @IBOutlet fileprivate weak var githubAccessTokenTextField: UITextField!
    @IBOutlet private weak var githubUsernameTextField: UITextField!
    @IBOutlet private weak var githubRepoTextField: UITextField!
    @IBOutlet private weak var githubIssuesButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        githubAccessTokenTextField.text = viewModel.accessTokenForGithub
        githubAccessTokenTextField.addTarget(self, action: #selector(changedGithubAccessToken(_:)), for: .editingChanged)
    }

    @IBAction func changedGithubAccessToken(_ textField: UITextField) {
        guard let value = textField.text else { return }
        viewModel.accessTokenForGithub = value
    }

    @IBAction func touchGithubIssues() {
        guard let username = githubUsernameTextField.text, let repo = githubRepoTextField.text else { return }
        GithubAuthentication.sharedInstance.accessToken = githubAccessTokenTextField.text
        
        let modelData: ModelData = .userAndRepo(user: username, repo: repo)
        let router = IssueRouter(navigationController: self.navigationController, viewController: self)
        router.routeIssues(data: modelData)
    }
}