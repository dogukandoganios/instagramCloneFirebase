//
//  ViewController.swift
//  instagramCloneFirebase
//
//  Created by Doğukan Doğan on 20.07.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var instagramLabel = UILabel()
    var emailTextField = UITextField()
    var passwordTextFiled = UITextField()
    var singinButton = UIButton()
    var singupButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        overrideUserInterfaceStyle = .light
        
        let width = view.layer.frame.width
        let height = view.layer.frame.height
        
        instagramLabel.text = "Instagram Clone Firebase"
        instagramLabel.font = UIFont(name: instagramLabel.font.fontName, size: 30)
        instagramLabel.textAlignment = .center
        instagramLabel.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.15 - height * 0.1 / 2, width: width * 0.8, height: height * 0.1)
        view.addSubview(instagramLabel)
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "E-mail address", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray.withAlphaComponent(0.5)])
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.textAlignment = .center
        emailTextField.frame = CGRect(x: width * 0.5 - width * 0.45 / 2, y: height * 0.25 - height * 0.05 / 2, width: width * 0.45, height: height * 0.05)
        view.addSubview(emailTextField)
        
        passwordTextFiled.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray.withAlphaComponent(0.5)])
        passwordTextFiled.layer.borderWidth = 1
        passwordTextFiled.layer.borderColor = UIColor.black.cgColor
        passwordTextFiled.textAlignment = .center
        passwordTextFiled.frame = CGRect(x: width * 0.5 - width * 0.45 / 2, y: height * 0.32 - height * 0.05 / 2, width: width * 0.45, height: height * 0.05)
        view.addSubview(passwordTextFiled)
        
        singinButton.setTitle("Sing In", for: UIControl.State.normal)
        singinButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        singinButton.frame = CGRect(x: width * 0.25 - width * 0.16 / 2, y: height * 0.39 - height * 0.05 / 2, width: width * 0.16, height: height * 0.05)
        singinButton.addTarget(self, action: #selector(singinClick), for: UIControl.Event.touchUpInside)
        view.addSubview(singinButton)
        
        singupButton.setTitle("Sing Up", for: UIControl.State.normal)
        singupButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        singupButton.frame = CGRect(x: width * 0.75 - width * 0.16 / 2, y: height * 0.39 - height * 0.05 / 2, width: width * 0.16, height: height * 0.05)
        singupButton.addTarget(self, action: #selector(singupClick), for: UIControl.Event.touchUpInside)
        view.addSubview(singupButton)
        
        
    }
    
    @objc func singinClick(){
        
        performSegue(withIdentifier: "seagueSingIn", sender: nil)
        
    }
    
    @objc func singupClick(){
        
    }


}

