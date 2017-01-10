//
// Created by Chope on 2017. 1. 7..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import Kingfisher
import BonMot

class IssueTableViewCell: UITableViewCell {
    var onTouchedUser: (()->Void)?

    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var userImageButton: UserThumbnailButton!
    @IBOutlet fileprivate weak var usernameLabel: UILabel!

    fileprivate var title: String?
    fileprivate var number: String = ""

    override func awakeFromNib() {
        super.awakeFromNib()

        userImageButton.addTarget(self, action: #selector(onTouchedUserPhoto), for: .touchUpInside)
    }

    fileprivate func updateTitle() {
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
                "#\(number)".styled(with: styleOfId),
                Tab.headIndent(10),
                title.styled(with: styleOfTitle)
        ])
    }

    func onTouchedUserPhoto() {
        onTouchedUser?()
    }
}

extension IssueTableViewCell: IssuesCellView {
    func set(title: String) {
        self.title = title
        updateTitle()
    }

    func set(number: String) {
        self.number = number
        updateTitle()
    }

    func set(username: String?) {
        usernameLabel.text = username
    }

    func set(userPhotoURL: URL?) {
        userImageButton.kf.setBackgroundImage(with: userPhotoURL, for: .normal, placeholder: UIImage(named: "imgAvatarPlaceholder"))
    }
}