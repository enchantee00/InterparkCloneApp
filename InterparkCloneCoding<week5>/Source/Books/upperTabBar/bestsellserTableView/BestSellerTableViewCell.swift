//
//  bestsellerTableViewCell.swift
//  InterparkCloneCoding<week5>
//
//  Created by 정지윤 on 2021/12/27.
//

import UIKit

class BestSellerCell: UITableViewCell {
    
    
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var bookImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bookName.sizeToFit()
        authorName.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
