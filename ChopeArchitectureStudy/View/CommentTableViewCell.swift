//
// Created by Chope on 2017. 1. 15..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet fileprivate weak var bodyTextView: UITextView!
    @IBOutlet fileprivate weak var usernameLabel: UILabel!
    @IBOutlet fileprivate weak var userPhotoButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        bodyTextView.backgroundColor = UIColor.clear
    }

    func set(comment: Comment) {
        bodyTextView.text = comment.body

        if let user = comment.user {
            usernameLabel.text = user.login
            userPhotoButton.kf.setBackgroundImage(with: user.avatarURL, for: .normal, placeholder: UIImage(named: "imgAvatarPlaceholder"))
        }
    }
}
