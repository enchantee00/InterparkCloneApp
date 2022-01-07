//
//  MovieViewController.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import UIKit

class BSBookViewController: BaseViewController {
    
    var book : BestSellerBook!
    
    @IBOutlet weak var mainImg : UIImageView!
    @IBOutlet weak var bookName : UILabel!
    @IBOutlet weak var author : UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: book.coverSmallUrl) {
            let data = try? Data(contentsOf: url)
            mainImg.image = UIImage(data: data!)
        } else {
            print("cannot conver to Data")
        }
        
        bookName.text = book.title
        author.text = book.author
        
        
    }
}

