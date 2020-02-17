//
//  CommentViewController.swift
//  Doggable
//
//  Created by higuchiryunosuke on 2020/02/11.
//  Copyright © 2020 higuchiryunosuke. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class CommentViewController: UIViewController {

    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var constraintToBottom: NSLayoutConstraint!
    
    
    var postId: String!
    var comments = [Comment]()
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Comment"
//        sendButton.isEnabled = false
        tableView.dataSource = self
        tableView.rowHeight = 140
        tableView.estimatedRowHeight = 140
//        tableView.rowHeight = UITableViewAutomaticDimention
        empty()
        handleTextField()
        loadComments()
        
//        //キーボードが表示されるタイミングで呼び出される。
//        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShow(notification:)),name: UIResponder.keyboardWillShowNotification,object: nil)
//        // キーボードが消えるタイミングで呼び出される。
//        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillHide(notification:)),name: UIResponder.keyboardWillHideNotification,object: nil)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }
//    @objc func keyboardWillShow(_ notification: NSNotification) {
//        print(notification)
//        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
//        UIView.animate(withDuration: 0.3) {
//            self.constraintToBottom.constant = keyboardFrame!.height
//            self.view.layoutIfNeeded()
//        }
//    }
//    func keyboardWillHide(_ notification: NSNotification) {
//        UIView.animate(withDuration: 0.3) {
//            self.constraintToBottom.constant = 0
//            self.view.layoutIfNeeded()
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabBarController?.tabBar.isHidden = true
    }
    
    func loadComments() {
        Api.Post_Comment.REF_POST_COMMENTS.child(self.postId).observe(.childAdded) { (snapshot) in
            Api.Comment.observeComments(withPostId: snapshot.key) { (comment) in
                self.fetchUser(uid: comment.uid!, completed: {
                    self.comments.append(comment)
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    func fetchUser(uid: String, completed: @escaping () -> Void) {
        Api.User.observeUser(withId: uid) { (user) in
            self.users.append(user)
            completed()
        }
    }
    
    func handleTextField() {
        commentTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange() {
        if let commentText = commentTextField.text, !commentText.isEmpty {
//            sendButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
//            sendButton.isEnabled = true
        }
//        sendButton.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
//        sendButton.isEnabled = false
    }

    
    @IBAction func sendButton_TouchUpInside(_ sender: Any) {
        let commentsReference = Api.Comment.REF_COMMENTS
        let newCommentId = commentsReference.childByAutoId().key
        let newCommentReference = commentsReference.child(newCommentId!)
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let currentUserId = currentUser.uid
        newCommentReference.setValue(["uid": currentUserId, "comentText": commentTextField.text!], withCompletionBlock: {
            (error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
//            let postId = "M-mDdK-i9KhWs_RMC0O"
            let postCommentRef = Api.Post_Comment.REF_POST_COMMENTS.child(self.postId).child(newCommentId!)
            postCommentRef.setValue(true) { (error, ref) in
                if error != nil {
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }
            }
            self.empty()
        })
    }
    func empty() {
        self.commentTextField.text = ""
//        self.sendButton.isEnabled = false
//        self.sendButton.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
    }
}

extension CommentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        let comment = comments[indexPath.row]
        let user = users[indexPath.row]
        cell.comment = comment
        cell.user = user
        return cell
    }
}
