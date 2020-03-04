//
//  PhotoCollectionViewCell.swift
//  Doggable
//
//  Created by higuchiryunosuke on 2020/02/26.
//  Copyright © 2020 higuchiryunosuke. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
    var post: Post? {
        didSet {
            updateView()
        }
    }
    func updateView() {
        if let photoUrlString = post?.photoUrl {
            let photoUrl = URL(string: photoUrlString)
            photo.sd_setImage(with: photoUrl)
        }
    }
}
