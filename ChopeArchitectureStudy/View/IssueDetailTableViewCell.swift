//
// Created by Chope on 2017. 1. 15..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import Kingfisher

class IssueDetailTableViewCell: UITableViewCell {
    weak var viewModel: IssueCellViewModel! {
        didSet {
            display()
        }
    }

    @IBOutlet fileprivate weak var userImageButton: UserThumbnailButton!
    @IBOutlet fileprivate weak var usernameLabel: UILabel!
    @IBOutlet fileprivate weak var bodyTextView: UITextView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.backgroundColor = UIColor.clear
        bodyTextView.backgroundColor = UIColor.clear
    }

    func display() {
        set(title: viewModel.title)
        set(body: viewModel.body)
        set(username: viewModel.username, imageURL: viewModel.userImageURL)
    }

    private func set(title: String) {
        titleLabel.text = title
    }

    private func set(body: String) {
        bodyTextView.text = body
    }

    private func set(username: String?, imageURL: URL?) {
        usernameLabel.text = username
        userImageButton.kf.setBackgroundImage(with: imageURL, for: .normal, placeholder: UIImage(named: "imgAvatarPlaceholder"))
    }
}