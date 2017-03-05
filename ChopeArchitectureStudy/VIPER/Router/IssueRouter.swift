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
        guard let navigationController = navigationController else { return }
        let vc = UIViewController.issues(data: data, navigationController: navigationController)
        push(viewController: vc, animated: true)
    }

    func routeCreation(data: ModelData) {
        guard let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "createIssue") as? UINavigationController,
              let viewController = navigationController.viewControllers.first as? IssueCreationViewController
        else { return }
        viewController.viewModel = IssueCreationViewModel(data: data)
        present(viewController: navigationController, animated: true)
    }

    func routeDetail(data: ModelData) {
        guard let navigationController = navigationController else { return }
        let vc = UIViewController.issueDetail(data: data, navigationController: navigationController)
        push(viewController: vc, animated: true)
    }
}

private extension UIViewController {
    class func issues(data: ModelData, navigationController: UINavigationController) -> IssuesViewController {
        switch data {
        case .userAndRepo:
            break
        default:
            assertionFailure()
        }

        let interactor = GithubIssuesInteractor()
        interactor.model = IssuesModel(data: data)

        let presenter = IssuesPresenter()
        presenter.interactor = interactor
        presenter.router = IssueRouter(navigationController: navigationController)

        let vc = IssuesViewController()
        vc.presenter = presenter
        return vc
    }

    class func issueAndComments(data: ModelData, navigationController: UINavigationController) -> IssueAndCommentsViewController {
        switch data {
        case .userAndRepoWithNumber:
            break
        default:
            assertionFailure()
        }

        let commentsInteractor = GithubCommentsInteractor()
        commentsInteractor.model = CommentsModel(data: data)

        let issueInteractor = GithubIssueInteractor()
        issueInteractor.model = IssueDetailModel(data: data)

        let presenter = IssueAndCommentsPresenter()
        presenter.commentsInteractor = commentsInteractor
        presenter.issueInteractor = issueInteractor
        presenter.router = IssueRouter(navigationController: navigationController)

        let vc = IssueAndCommentsViewController()
        vc.presenter = presenter
        return vc
    }

    class func issueDetail(data: ModelData, navigationController: UINavigationController) -> IssueDetailViewController {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "issueDetail") as? IssueDetailViewController else {
            assertionFailure()
            return IssueDetailViewController()
        }
        let issueAndCommentsVC = issueAndComments(data: data, navigationController: navigationController)
        vc.issueAndCommentsViewController = issueAndCommentsVC
        return vc
    }
}