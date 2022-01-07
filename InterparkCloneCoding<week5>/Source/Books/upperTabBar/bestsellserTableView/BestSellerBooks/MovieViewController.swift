//
//  MovieViewController.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import UIKit

class MovieViewController: BaseViewController {
    
    var movie: Movie!
    
    
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieNameLabel.text = movie.movieNm
    }
}
