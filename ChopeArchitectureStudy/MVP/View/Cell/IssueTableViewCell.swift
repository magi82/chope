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
    @IBOutlet fileprivate weak var commentsLabel: UILabel!

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

    func set(countOfComments: Int?) {
        guard let countOfComments = countOfComments else {
            commentsLabel.attributedText = nil
            return
        }

        let title: String = "comments : "
        let comments: String = "\(countOfComments)"

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

    func setUser(name: String, photoURL: URL?) {
        usernameLabel.text = name
        userImageButton.kf.setBackgroundImage(with: photoURL, for: .normal, placeholder: UIImage(named: "imgAvatarPlaceholder"))
    }
}