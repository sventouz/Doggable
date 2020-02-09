//
//  Post.swift
//  Doggable
//
//  Created by higuchiryunosuke on 2020/02/09.
//  Copyright © 2020 higuchiryunosuke. All rights reserved.
//

import Foundation

class Post {
    var caption: String?
    var photoUrl: String?
}

extension Post {
    static func transformPost(dict: [String: Any]) -> Post {
        let post  = Post()
        post.caption = dict["caption"] as? String
        post.photoUrl = dict["photoUrl"] as? String
        return post
    }
}
