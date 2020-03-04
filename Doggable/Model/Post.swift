//
//  Post.swift
//  Doggable
//
//  Created by higuchiryunosuke on 2020/02/09.
//  Copyright © 2020 higuchiryunosuke. All rights reserved.
//

import Foundation
import FirebaseAuth

class Post {
    var caption: String?
    var photoUrl: String?
    var uid: String?
    var id: String?
    var likeCount: Int?
    var likes: Dictionary<String, Any>?
    var isLiked: Bool?
}

extension Post {
    static func transformPostPhoto(dict: [String: Any], key: String) -> Post {
        let post  = Post()
        post.id = key
        post.caption = dict["caption"] as? String
        post.photoUrl = dict["photoUrl"] as? String
        post.uid = dict["uid"] as? String
        post.likeCount = dict["likeCount"] as? Int
        post.likes = dict["likes"] as? Dictionary<String, Any>
        if let currentUserId = Auth.auth().currentUser?.uid {
            if post.likes != nil {
                post.isLiked = post.likes![currentUserId] != nil
            }
        }
        return post
    }
}
