//
//  HeaderProfileCollectionReusableView.swift
//  Doggable
//
//  Created by higuchiryunosuke on 2020/02/20.
//  Copyright © 2020 higuchiryunosuke. All rights reserved.
//

import UIKit

class HeaderProfileCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myPostCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    func updateView() {
        Api.User.REF_CURRENT_USER?.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            if let dict = snapshot.value as? [String: Any] {
                let user = User.transformUser(dict: dict)
                self.nameLabel.text = user.username
                if let photoUrlString = user.profileImageUrl {
                    let photoUrl = URL(string: photoUrlString)
                    self.profileImage.sd_setImage(with: photoUrl)
                }
            }
        })
    }
}

