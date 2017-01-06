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
            userImageButton.kf.setImage(with: userImageURL, for: .normal, placeholder: UIImage(named: "imgAvatarPlaceholder"))
        }
    }

    var onTouchedUser: (()->Void)?

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var userImageButton: UIButton!
    @IBOutlet private weak var usernameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        userImageButton.layer.cornerRadius = userImageButton.bounds.midX
        userImageButton.layer.masksToBounds = true
        userImageButton.layer.borderColor = UIColor.lightGray.cgColor
        userImageButton.layer.borderWidth = 1.0

        userImageButton.addTarget(self, action: #selector(onTouchedUserPhoto), for: .touchUpInside)
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

    func onTouchedUserPhoto() {
        onTouchedUser?()
    }
}
