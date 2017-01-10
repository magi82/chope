//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit

class RepositoryServicesViewController: UIViewController {
    @IBOutlet private weak var githubAccessTokenTextField: UITextField!
    @IBOutlet private weak var githubIssuesButton: UIButton!
    @IBOutlet private weak var bitbucketAPIKeyTextField: UITextField!
    @IBOutlet private weak var bitbucketIssuesButton: UIButton!

    override func prepare(`for` segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        guard let viewController = segue.destination as? IssuesViewController else { return }

        if segue.identifier == "bitbucketIssues" {
            let model = BitbucketIssuesModel(user: "birkenfeld", repo: "pygments-main")
            viewController.presenter = IssuesPresenter(model: model)
        } else if segue.identifier == "githubIssues" {
            let model = GithubIssuesModel(user: "Alamofire", repo: "Alamofire")
            viewController.presenter = IssuesPresenter(model: model)
        }
    }
}
