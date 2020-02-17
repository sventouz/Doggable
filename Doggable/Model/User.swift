//
//  User.swift
//  Doggable
//
//  Created by higuchiryunosuke on 2020/02/11.
//  Copyright © 2020 higuchiryunosuke. All rights reserved.
//

import Foundation

class User {
    var email: String?
    var profileImageUrl: String?
    var username: String?
}

extension User {
    static func transformUser(dict: [String: Any]) -> User {
        let user = User()
        user.email = dict["email"] as? String
        user.profileImageUrl = dict["profileImageUrl"] as? String
        user.username = dict["username"] as? String
        
        return user
    }
}
