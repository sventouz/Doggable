//
//  FollowApi.swift
//  Doggable
//
//  Created by higuchiryunosuke on 2020/02/29.
//  Copyright © 2020 higuchiryunosuke. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class FollowApi {
    var REF_FOLLOWERS = Database.database().reference().child("followers")
    var REF_FOLLOWING = Database.database().reference().child("following")
    
    func followAction(withUser id: String) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        Api.MyPosts.REF_MY_POST.child(id).observeSingleEvent(of: .value) { (snapshot) in
            guard let currentUser = Auth.auth().currentUser else {
                return
            }
            if let dict = snapshot.value as? [String: Any] {
                for key in dict.keys {
                    Database.database().reference().child("feed").child(currentUser.uid).child(key).setValue(true)
                }
            }
        }
        Api.Follow.REF_FOLLOWERS.child(id).child(currentUser.uid).setValue(true)
        Api.Follow.REF_FOLLOWING.child(currentUser.uid).child(id).setValue(true)
    }
    
    func unFollowAction(withUser id: String) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        Api.MyPosts.REF_MY_POST.child(id).observeSingleEvent(of: .value) { (snapshot) in
            guard let currentUser = Auth.auth().currentUser else {
                return
            }
            if let dict = snapshot.value as? [String: Any] {
                for key in dict.keys {
                    Database.database().reference().child("feed").child(currentUser.uid).child(key).removeValue()
                }
            }
        }
        Api.Follow.REF_FOLLOWERS.child(id).child(currentUser.uid).setValue(NSNull())
        Api.Follow.REF_FOLLOWING.child(currentUser.uid).child(id).setValue(NSNull())
    }
    
    func isFollowing(userId: String, completed: @escaping(Bool) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        Api.Follow.REF_FOLLOWERS.child(userId).child(currentUser.uid).observeSingleEvent(of: .value) { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                completed(false)
            } else {
                completed(true)
            }
        }
    }
}
