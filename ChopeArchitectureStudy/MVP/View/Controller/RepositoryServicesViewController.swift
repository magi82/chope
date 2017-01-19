//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit

class RepositoryServicesViewController: UIViewController {
    var presenter: RepositoryServicesPresenter!

    @IBOutlet fileprivate weak var githubAccessTokenTextField: UITextField!
    @IBOutlet private weak var githubUsernameTextField: UITextField!
    @IBOutlet private weak var githubRepoTextField: UITextField!
    @IBOutlet private weak var githubIssuesButton: UIButton!
    @IBOutlet fileprivate weak var bitbucketAPIKeyTextField: UITextField!
    @IBOutlet private weak var bitbucketUsernameTextField: UITextField!
    @IBOutlet private weak var bitbucketRepoTextField: UITextField!
    @IBOutlet private weak var bitbucketIssuesButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = RepositoryServicesPresenter(view: self)
        presenter.load()

        githubAccessTokenTextField.addTarget(self, action: #selector(changedGithubAccessToken(_:)), for: .editingChanged)
    }

    override func prepare(`for` segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        guard let viewController = segue.destination as? IssuesViewController else { return }

        if segue.identifier == "bitbucketIssues" {
            let model = BitbucketIssuesModel(user: "birkenfeld", repo: "pygments-main")
            viewController.presenter = IssuesPresenter(model: model)
        } else if segue.identifier == "githubIssues" {
            GithubAuthentication.sharedInstance.accessToken = githubAccessTokenTextField.text

            guard let username = githubUsernameTextField.text, let repo = githubRepoTextField.text else { return }
            let model = GithubIssuesModel(user: username, repo: repo)
            viewController.presenter = IssuesPresenter(model: model)
        }
    }

    @IBAction func changedGithubAccessToken(_ textField: UITextField) {
        guard let value = textField.text else { return }
        presenter.setGithubAccessToken(token: value)
    }

    @IBAction func changedBitbucketAPIKey(_ textField: UITextField) {
        guard let value = textField.text else { return }
        presenter.setBitbucketAPIKey(key: value)
    }
}


extension RepositoryServicesViewController: RepositoryServicesView {
    func setGithubAccessToken(token: String?) {
        githubAccessTokenTextField.text = token
    }

    func setBitbucketAPIKey(apiKey: String?) {
        bitbucketAPIKeyTextField.text = apiKey
    }
}