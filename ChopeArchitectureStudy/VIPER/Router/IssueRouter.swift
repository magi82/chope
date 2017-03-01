//
// Created by Chope on 2017. 2. 28..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit

class IssueRouter: Router {
    var navigationController: UINavigationController?
    var viewController: UIViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.viewController = navigationController
    }

    init(viewController: UIViewController) {
        self.navigationController = viewController.navigationController
        self.viewController = viewController
    }

    func routeIssues(data: ModelData) {
        let viewModel = IssuesViewModel(data: data)
        let viewController = IssuesViewController()
        viewController.viewModel = viewModel
        push(viewController: viewController, animated: true)
    }

    func routeCreation(data: ModelData) {
        guard let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "createIssue") as? UINavigationController,
              let viewController = navigationController.viewControllers.first as? IssueCreationViewController
        else { return }
        viewController.viewModel = IssueCreationViewModel(data: data)
        present(viewController: navigationController, animated: true)
    }

    func routeDetail(data: ModelData, issueNumber: Int) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "issueDetail") as? IssueDetailViewController else { return }
        viewController.viewModel = CommentsWithIssueViewModel(data: data, issueNumber: issueNumber)
        push(viewController: viewController, animated: true)
    }
}
