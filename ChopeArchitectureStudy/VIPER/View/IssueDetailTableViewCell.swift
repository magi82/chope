//
// Created by Chope on 2017. 1. 15..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import Kingfisher

class IssueDetailTableViewCell: UITableViewCell {
    @IBOutlet private weak var userImageButton: UserThumbnailButton!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var bodyTextView: UITextView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        bodyTextView.removeAllPadding()
    }

    func set(title: String) {
        titleLabel.text = title
    }

    func set(body: String) {
        bodyTextView.text = body
    }

    func set(username: String?, imageURL: URL?) {
        usernameLabel.text = username
        userImageButton.kf.setBackgroundImage(with: imageURL, for: .normal, placeholder: UIImage(named: "imgAvatarPlaceholder"))
    }
}
