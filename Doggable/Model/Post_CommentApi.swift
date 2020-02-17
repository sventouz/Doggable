//
//  Post_CommentApi.swift
//  Doggable
//
//  Created by higuchiryunosuke on 2020/02/17.
//  Copyright © 2020 higuchiryunosuke. All rights reserved.
//

import Foundation
import FirebaseDatabase
class Post_CommentApi {
    var REF_POST_COMMENTS = Database.database().reference().child("post-comments")
}
