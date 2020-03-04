////
////  HelperService.swift
////  Doggable
////
////  Created by higuchiryunosuke on 2020/02/28.
////  Copyright © 2020 higuchiryunosuke. All rights reserved.
////
//
//import Foundation
//import FirebaseStorage
//
//class HelperService {
//    static func uploadDataToServer(data: Data, caption: String, onSuccess: @escaping() -> Void) {
//        let photoIdString = NSUUID().uuidString
//        let storageRef = Storage.storage().reference(forURL: config.STRAGE_ROOT_REF).child("posts").child(photoIdString)
//        storageRef.putData(data, metadata: nil) { (metadata, error) in
//            if error != nil {
//                ProgressHUD.showError(error!.localizedDescription)
//                return
//            }
//            let photoUrl = metadata?.downloadURL()?.absoluteString
//            self.sendDataToDatabase(photoUrl: String)
//        }
//    }
//    
//    static func  sendDataToDatabase(data: Data, caption: String, onSuccess: @escaping() -> Void) {
//        let newPostId = Api.Post.REF_POSTS.childByAutoId().key
//        let newPostReference = Api.Post.REF_POSTS.child(newPostId)
//        guard  let currentUser = Api.User else {
//            <#statements#>
//        }
//    }
//}
