//
//  uploadViewController.swift
//  instagramCloneFirebase
//
//  Created by Doğukan Doğan on 20.07.2022.
//

import UIKit
import Firebase
import FirebaseStorage

class uploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let selectImageView = UIImageView()
    let commenctTextFiled = UITextField()
    let uploadButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        selectImageView.image = UIImage(named: "selectimage")
        selectImageView.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.3 - height * 0.3 / 2, width: width * 0.8, height: height * 0.3)
        view.addSubview(selectImageView)
        
        selectImageView.isUserInteractionEnabled = true
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(imageClick))
        selectImageView.addGestureRecognizer(imageGesture)
        
        commenctTextFiled.attributedPlaceholder = NSAttributedString(string: "Comment", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray.withAlphaComponent(0.5)])
        commenctTextFiled.layer.borderWidth = 1
        commenctTextFiled.layer.borderColor = UIColor.black.cgColor
        commenctTextFiled.textAlignment = .center
        commenctTextFiled.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.5 - height * 0.05 / 2, width: width * 0.8, height: height * 0.05)
        view.addSubview(commenctTextFiled)
        
        uploadButton.setTitle("Upload", for: UIControl.State.normal)
        uploadButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        uploadButton.frame = CGRect(x: width * 0.5 - width * 0.16 / 2, y: height * 0.6 - height * 0.05, width: width * 0.16, height: height * 0.05)
        uploadButton.addTarget(self, action: #selector(uploadClick), for: UIControl.Event.touchUpInside)
        uploadButton.isEnabled = false
        view.addSubview(uploadButton)
        
        
    }
    
    @objc func uploadClick(){
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("media")
        
        if let data = selectImageView.image?.jpegData(compressionQuality: 0.5){
            
            
            let uuidString = UUID().uuidString
            
            let mediaRef = mediaFolder.child("\(uuidString).jpg")
            mediaRef.putData(data, metadata: nil) { (metadata, error) in
                
                if error != nil {
                    
                    self.alert(title: "Error", message: error!.localizedDescription)
                    
                }else{
                    
                    mediaRef.downloadURL { url, error in
                        
                        if error != nil {
                            
                            self.alert(title: "Error", message: "1\(error!.localizedDescription)")
                            
                        }else{
                            
                            let imageUrl = url?.absoluteString
                            
                            let firestoreDatabase = Firestore.firestore()
                            let firestoreRef : DocumentReference?
                            var firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email, "postComment" : self.commenctTextFiled.text!, "postDate" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
                        
                            firestoreRef = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                
                                if error != nil{
                                    
                                    self.alert(title: "Error", message: error!.localizedDescription)
                                    
                                }else{
                                    
                                    self.selectImageView.image = UIImage(named: "selectimage")
                                    self.commenctTextFiled.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                    
                                }
                                
                            })
                        }
                        
                    }
                    
                }
            }
            
        }
        
    }
    
    func alert(title : String, message : String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func imageClick(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        selectImageView.image = info[.editedImage] as? UIImage
        uploadButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)
        
    }
    

}
