//
// Created by Chope on 2017. 1. 8..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import Kingfisher
import BonMot

class IssueDetailViewController: UIViewController {
    var presenter: IssueDetailPresenter!

    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var bodyTextView: UITextView!
    @IBOutlet fileprivate weak var userImageButton: UserThumbnailButton!
    @IBOutlet fileprivate weak var usernameLabel: UILabel!
    @IBOutlet private weak var topBorderViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        bodyTextView.contentInset = UIEdgeInsets()
        bodyTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)

        topBorderViewHeightConstraint.constant = 1 / UIScreen.main.scale

        assert(presenter != nil)
        presenter.view = self
        presenter.issue()
    }
}

extension IssueDetailViewController: IssueDetailView {
    func set(number: Int) {
        navigationItem.title = "#\(number)"
    }

    func set(title: String) {
        titleLabel.text = title
    }

    func set(body: String) {
        bodyTextView.text = body
    }

    func set(username: String) {
        usernameLabel.text = username
    }

    func set(userPhotoURL: URL) {
        userImageButton.kf.setImage(with: userPhotoURL, for: .normal, placeholder: UIImage(named: "imgAvatarPlaceholder"))
    }

}