//
//  PostApi.swift
//  Doggable
//
//  Created by higuchiryunosuke on 2020/02/17.
//  Copyright © 2020 higuchiryunosuke. All rights reserved.
//

import Foundation
import FirebaseDatabase
class PostApi {
    var REF_POSTS = Database.database().reference().child("posts")
    
    func observePosts(completion: @escaping(Post)-> Void) {
        REF_POSTS.observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let newPost = Post.transformPost(dict: dict, key: snapshot.key)
                completion(newPost)
            }
        }
    }
}
