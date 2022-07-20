//
//  settingsViewController.swift
//  instagramCloneFirebase
//
//  Created by Doğukan Doğan on 20.07.2022.
//

import UIKit
import Firebase

class settingsViewController: UIViewController {
    
    var logoutButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        logoutButton.setTitle("Log Out", for: UIControl.State.normal)
        logoutButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        logoutButton.frame = CGRect(x: width * 0.9 - width * 0.16 / 2, y: height * 0.1 - height * 0.05 / 2, width: width * 0.16, height: height * 0.05)
        logoutButton.addTarget(self, action: #selector(logoutClick), for: UIControl.Event.touchUpInside)
        view.addSubview(logoutButton)
    }
    
    @objc func logoutClick(){
        
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "logoutSegue", sender: nil)
        }catch{
            print("error")
        }
        
    }

}
