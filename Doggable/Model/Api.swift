//
//  Api.swift
//  Doggable
//
//  Created by higuchiryunosuke on 2020/02/17.
//  Copyright © 2020 higuchiryunosuke. All rights reserved.
//

import Foundation

struct Api {
    static var User = UserApi()
    static var Post = PostApi()
    static var Comment = CommentApi()
    static var Post_Comment = Post_CommentApi()
}
