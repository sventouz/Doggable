//
//  CommnetApi.swift
//  Doggable
//
//  Created by higuchiryunosuke on 2020/02/17.
//  Copyright © 2020 higuchiryunosuke. All rights reserved.
//

import Foundation
import FirebaseDatabase
class CommentApi {
    var REF_COMMENTS = Database.database().reference().child("comments")
    
    func observeComments(withPostId id: String, completion: @escaping (Comment) -> Void) {
        REF_COMMENTS.child(id).observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let newComment = Comment.transformComment(dict: dict)
                completion(newComment)
            }
        }
    }
}
