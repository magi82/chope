//
// Created by Chope on 2017. 1. 15..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import Kingfisher

class CommentTableViewCell: UITableViewCell {
    var onTouchedUser: (()->Void)?
    var viewModel: CommentCellViewModel! {
        didSet {
            display()
        }
    }

    @IBOutlet fileprivate weak var bodyTextView: UITextView!
    @IBOutlet fileprivate weak var usernameLabel: UILabel!
    @IBOutlet fileprivate weak var userImageButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        bodyTextView.removeAllPadding()

        userImageButton.addTarget(self, action: #selector(onTouchedUserImage), for: .touchUpInside)
    }

    private func display() {
        set(body: viewModel.body)
        set(username: viewModel.username, imageURL: viewModel.userImageURL)
    }

    private func set(username: String?, imageURL: URL?) {
        usernameLabel.text = username
        userImageButton.kf.setBackgroundImage(with: imageURL, for: .normal, placeholder: UIImage(named: "imgAvatarPlaceholder"))
    }

    private func set(body: String) {
        bodyTextView.text = body
    }

    func onTouchedUserImage() {

    }
}
