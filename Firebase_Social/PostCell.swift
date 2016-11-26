//
//  PostCell.swift
//  Firebase_Social
//
//  Created by Surachet Songsakaew on 11/24/2559 BE.
//  Copyright © 2559 Surachet Songsakaew. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var post:Post!
    
    
    @IBOutlet weak var profileImg:UIImageView!
    @IBOutlet weak var usernameLbl:UILabel!
    @IBOutlet weak var postImg:UIImageView!
    @IBOutlet weak var caption:UITextView!
    @IBOutlet weak var likeLbl:UILabel!
    
    
    func configureCell(post:Post){
       self.post = post
        self.caption.text = post.caption
        self.likeLbl.text = "\(post.like)"
        
        
    }
}
