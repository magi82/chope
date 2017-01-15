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
}

extension CommentTableViewCell: CommentCellView {
    func set(body: String) {
        bodyTextView.text = body
    }

    func setUser(name: String, photoURL: URL?) {
        usernameLabel.text = name
        userPhotoButton.kf.setBackgroundImage(with: photoURL, for: .normal, placeholder: UIImage(named: "imgAvatarPlaceholder"))
    }
}
