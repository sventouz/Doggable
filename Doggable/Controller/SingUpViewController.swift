//
//  SingUpViewController.swift
//  Doggable
//
//  Created by higuchiryunosuke on 2020/02/04.
//  Copyright © 2020 higuchiryunosuke. All rights reserved.
//

import UIKit

class SingUpViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = 50
        profileImage.clipsToBounds = true
    }
    
    @IBAction func dismiss_onClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
