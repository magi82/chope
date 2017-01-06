//
// Created by Chope on 2017. 1. 7..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import Kingfisher
import BonMot

class IssueTableViewCell: UITableViewCell {
    var id: Int = 0 {
        didSet {
            updateTitle()
        }
    }

    var title: String? {
        didSet {
            updateTitle()
        }
    }

    var username: String? {
        didSet {
            usernameLabel.text = username
        }
    }

    var userImageURL: URL? {
        didSet {
            userImageView.kf.setImage(with: userImageURL, placeholder: UIImage(named: "imgAvatarPlaceholder"))
        }
    }

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var usernameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        userImageView.layer.cornerRadius = userImageView.bounds.midX
        userImageView.layer.masksToBounds = true
        userImageView.layer.borderColor = UIColor.lightGray.cgColor
        userImageView.layer.borderWidth = 1.0
    }

    private func updateTitle() {
        guard let title = title else {
            titleLabel.text = nil
            return
        }

        let styleOfId = StringStyle(
                .font(UIFont.boldSystemFont(ofSize: 20))
        )
        let styleOfTitle = StringStyle(
                .font(UIFont.systemFont(ofSize: 16))
        )

        titleLabel.attributedText = NSAttributedString.composed(of: [
                "#\(id)".styled(with: styleOfId),
                Tab.headIndent(10),
                title.styled(with: styleOfTitle)
        ])
    }
}
