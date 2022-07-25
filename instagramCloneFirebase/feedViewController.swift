//
//  feedViewController.swift
//  instagramCloneFirebase
//
//  Created by Doğukan Doğan on 20.07.2022.
//

import UIKit
import Firebase
import SDWebImage

class feedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var postedByArray = [String]()
    var postedCommentArray = [String]()
    var likesArray = [Int]()
    var imagesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFormFirebase()
        
    }
    
    func getDataFormFirebase(){
        
        let fireStoreDataBase = Firestore.firestore()
        
        fireStoreDataBase.collection("Posts").order(by: "postDate", descending: true).addSnapshotListener { snapshot, error in
            
            if error != nil{
                
                self.alert(title: "Error", message: error!.localizedDescription)
                
            }else{
                
                self.postedByArray.removeAll(keepingCapacity: false)
                self.postedCommentArray.removeAll(keepingCapacity: false)
                self.likesArray.removeAll(keepingCapacity: false)
                self.imagesArray.removeAll(keepingCapacity: false)
                
                if snapshot?.isEmpty != true{
                    
                    for document in snapshot!.documents {
                        
                        if let postedBy = document.get("postedBy") as? String{
                            
                            self.postedByArray.append(postedBy)
                            
                        }
                        
                        if let comment = document.get("postComment") as? String{
                            
                            self.postedCommentArray.append(comment)
                            
                        }
                        
                        if let like = document.get("likes") as? Int{
                            
                            self.likesArray.append(like)
                            
                        }
                        
                        if let image = document.get("imageUrl") as? String{
                            
                            self.imagesArray.append(image)
                            
                        }
                        
                        self.tableView.reloadData()
                        
                    }
                    
                }else{
                    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! feedTableViewCell
        cell.postImage.sd_setImage(with: URL(string: imagesArray[indexPath.row]))
        print(imagesArray[indexPath.row])
        cell.emailLabel.text = postedByArray[indexPath.row]
        cell.commentLabel.text = postedCommentArray[indexPath.row]
        cell.likeLabel.text = String(likesArray[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return postedByArray.count
        
    }


}
