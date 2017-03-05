//
// Created by Chope on 2017. 1. 15..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import Kingfisher

class CommentTableViewCell: UITableViewCell {
    var onTouchedUser: (()->Void)?

    @IBOutlet private weak var bodyTextView: UITextView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var userImageButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        bodyTextView.removeAllPadding()

        userImageButton.addTarget(self, action: #selector(onTouchedUserImage), for: .touchUpInside)
    }

    func set(username: String?, imageURL: URL?) {
        usernameLabel.text = username
        userImageButton.kf.setBackgroundImage(with: imageURL, for: .normal, placeholder: UIImage(named: "imgAvatarPlaceholder"))
    }

    func set(body: String) {
        bodyTextView.text = body
    }

    func onTouchedUserImage() {
        onTouchedUser?()
    }
}
