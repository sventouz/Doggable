//
//  UserApi.swift
//  Doggable
//
//  Created by higuchiryunosuke on 2020/02/17.
//  Copyright © 2020 higuchiryunosuke. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
class UserApi {
    var REF_USER = Database.database().reference().child("users")
    
    func observeUser(withId uid: String, completion: @escaping (User) -> Void) {
        REF_USER.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let user = User.transformUser(dict: dict)
                completion(user)
            }
        }
    }
    
    var REF_CURRENT_USER: DatabaseReference? {
        guard let currentUser = Auth.auth().currentUser else {
            return nil
        }
        return REF_USER.child(currentUser.uid)
    }
}
