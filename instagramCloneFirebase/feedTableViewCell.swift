//
//  feedTableViewCell.swift
//  instagramCloneFirebase
//
//  Created by Doğukan Doğan on 21.07.2022.
//

import UIKit
import Firebase

class feedTableViewCell: UITableViewCell {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var documentId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButton(_ sender: Any) {
        
        let firesoteDatabase = Firestore.firestore()
        
        if let likecount = Int(likeLabel.text!){
            
            let likeStore = ["likes": likecount + 1] as [String : Any]
            
            firesoteDatabase.collection("Posts").document(documentId.text!).setData(likeStore, merge: true)
            
        }
        
    }
}
