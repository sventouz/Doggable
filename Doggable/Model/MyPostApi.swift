//
//  MyPostApi.swift
//  Doggable
//
//  Created by higuchiryunosuke on 2020/02/26.
//  Copyright © 2020 higuchiryunosuke. All rights reserved.
//

import Foundation
import FirebaseDatabase
class MyPostApi {
    var REF_MY_POST = Database.database().reference().child("myPosts")
}
