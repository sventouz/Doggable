//
//  HomeViewController.swift
//  Doggable
//
//  Created by higuchiryunosuke on 2020/02/04.
//  Copyright © 2020 higuchiryunosuke. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 521
//        tableView.rowHeight = UITableViewAutomaticDimention
        tableView.dataSource = self
        
        loadPosts()
    }
    
    func loadPosts() {
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let newPost = Post.transformPost(dict: dict)
                self.posts.append(newPost)
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func logout_TouchUpInside(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let storybourd = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = storybourd.instantiateViewController(withIdentifier: "signInViewController")
        self.present(signInVC, animated: true, completion: nil)
    }
    
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return posts.count
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsCell", for: indexPath) as! HomeTableViewCell
        cell.profileImageView.image = UIImage(named: "photo1")
        cell.nameLabel.text = "Steve"
        cell.postImageView.image = UIImage(named: "photo2")
        cell.captionLabel.text = "sampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletextsampletext"
        return cell
    }
}
