//
//  HomeViewController.swift
//  Doggable
//
//  Created by higuchiryunosuke on 2020/02/04.
//  Copyright © 2020 higuchiryunosuke. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
