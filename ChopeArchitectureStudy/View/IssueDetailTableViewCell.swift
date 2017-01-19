//
// Created by Chope on 2017. 1. 15..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import Kingfisher

class IssueDetailTableViewCell: UITableViewCell {
    @IBOutlet fileprivate weak var userPhotoButton: UserThumbnailButton!
    @IBOutlet fileprivate weak var usernameLabel: UILabel!
    @IBOutlet fileprivate weak var bodyTextView: UITextView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.backgroundColor = UIColor.clear
        bodyTextView.backgroundColor = UIColor.clear
    }

    func set(issue: Issue) {
        titleLabel.text = issue.title
        bodyTextView.text = issue.body

        if let user = issue.user {
            usernameLabel.text = user.login
            userPhotoButton.kf.setBackgroundImage(with: user.avatarURL, for: .normal, placeholder: UIImage(named: "imgAvatarPlaceholder"))
        }
    }
}