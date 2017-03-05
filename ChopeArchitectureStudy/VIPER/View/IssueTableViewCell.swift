//
// Created by Chope on 2017. 1. 7..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import Kingfisher
import BonMot

class IssueTableViewCell: UITableViewCell {
    var onTouchedUser: (()->Void)?

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var userImageButton: UserThumbnailButton!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var commentsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        userImageButton.addTarget(self, action: #selector(onTouchedUserImage), for: .touchUpInside)
    }

    func set(number: Int, title: String) {
        let styleOfId = StringStyle(
                .font(UIFont.boldSystemFont(ofSize: 20))
        )
        let styleOfTitle = StringStyle(
                .font(UIFont.systemFont(ofSize: 16))
        )

        titleLabel.attributedText = NSAttributedString.composed(of: [
                "#\(number)".styled(with: styleOfId),
                Tab.headIndent(10),
                title.styled(with: styleOfTitle)
        ])
    }

    func set(numberOfComments: Int?) {
        guard let numberOfComments = numberOfComments else {
            commentsLabel.attributedText = nil
            return
        }

        let title: String = "comments : "
        let comments: String = "\(numberOfComments)"

        let styleOfTitle = StringStyle(
                .font(UIFont.boldSystemFont(ofSize: 10)),
                .color(UIColor.lightGray)
        )
        let styleOfComments = StringStyle(
                .font(UIFont.systemFont(ofSize: 14))
        )

        commentsLabel.attributedText = NSAttributedString.composed(of: [
                title.styled(with: styleOfTitle),
                comments.styled(with: styleOfComments)
        ])
    }

    func set(username: String?, imageURL: URL?) {
        usernameLabel.text = username
        userImageButton.kf.setBackgroundImage(with: imageURL, for: .normal, placeholder: UIImage(named: "imgAvatarPlaceholder"))
    }

    func onTouchedUserImage() {
        onTouchedUser?()
    }
}