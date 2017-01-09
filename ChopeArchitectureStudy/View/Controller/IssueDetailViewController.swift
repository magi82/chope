//
// Created by Chope on 2017. 1. 8..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import Kingfisher
import BonMot

class IssueDetailViewController: UIViewController {
    var issueModel: GithubIssueDetailModel!

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyTextView: UITextView!
    @IBOutlet private weak var userImageButton: UserThumbnailButton!
    @IBOutlet private weak var usernameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        bodyTextView.contentInset = UIEdgeInsets()
        bodyTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)

        NotificationCenter.default.addObserver(self, selector: #selector(onChangeIssue), name: GithubIssueDetailModel.ChangedNotification, object: nil)

        assert(issueModel != nil)
        issueModel.load()
    }

    func onChangeIssue() {
        display()
    }

    func display() {
        let issue = issueModel.issue

        navigationItem.title = "#\(issue.number)"

        let styleOfTitle = StringStyle(
                .font(UIFont.boldSystemFont(ofSize: 20))
        )

        titleLabel.attributedText = issue.title.styled(with: styleOfTitle)
        bodyTextView.text = issue.body

        guard let user = issue.user else { return }
        usernameLabel.text = user.name

        if let userImageUrl = URL(string: user.photoUrl) {
            userImageButton.kf.setImage(with: userImageUrl, for: .normal, placeholder: UIImage(named: "imgAvatarPlaceholder"))
        }
    }
}
