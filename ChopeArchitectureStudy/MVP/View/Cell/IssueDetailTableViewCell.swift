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
}

extension IssueDetailTableViewCell: IssueDetailCellView {
    func set(title: String) {
        titleLabel.text = title
    }

    func set(body: String) {
        bodyTextView.text = body
    }

    func setUser(name: String, userPhotoURL: URL?) {
        usernameLabel.text = name
        userPhotoButton.kf.setBackgroundImage(with: userPhotoURL, for: .normal, placeholder: UIImage(named: "imgAvatarPlaceholder"))
    }
}