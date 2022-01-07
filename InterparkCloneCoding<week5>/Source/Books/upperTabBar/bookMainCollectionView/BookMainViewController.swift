//
//  bookMainViewController.swift
//  InterparkCloneCoding<week5>
//
//  Created by 정지윤 on 2021/12/24.
//

import Foundation
import UIKit

class BookMainViewController : BaseViewController {
    
    var images = ["bookmain1", "bookmain2", "bookmain3", "bookmain4"]
    
    
    lazy var dataManager: BookDataManager = BookDataManager()
    var books : [Book] = []
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    @IBOutlet weak var newBookCollection: UICollectionView!
    
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
           
       // images라는 배열에서 pageControl이 가르키는 현재 페이지에 해당하는 이미지를 imgView에 할당
       imgView.image = UIImage(named: images[pageControl.currentPage])
   }
       
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //페이지 컨트롤의 전체 페이지를 images 배열의 전체 개수 값으로 설정
        pageControl.numberOfPages = images.count
        // 페이지 컨트롤의 현재 페이지를 0으로 설정
        pageControl.currentPage = 0
        // 페이지 표시 색상을 밝은 회색 설정
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        // 현재 페이지 표시 색상을 검정색으로 설정
        pageControl.currentPageIndicatorTintColor = UIColor.red
        imgView.image = UIImage(named: images[0])
        
        self.newBookCollection.delegate = self
        self.newBookCollection.dataSource = self
        
        
        self.showIndicator()
        dataManager.searchNewBooks(categoryId: "100", urlType: "newBook", delegate: self)
    
    }
}

extension BookMainViewController {
    
    func didRetrieveBooks(result: [Book]) { //책의 내용을 통째로 받아온 후, 테이블 뷰 Or 셀 클릭했을 때 뿌려줄 정보 나누어서 각자 뿌려준다.
        self.dismissIndicator()
        
        for i in 0..<5 {
            books.append(result[i])
        }
        newBookCollection.reloadData() //데이터를 받아와서 셀에 띄울 때 -> 데이터가 변경될 떄 사용
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}


extension BookMainViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let width = collectionView.frame.width / 3 + 10 ///  3등분하여 배치, 옆 간격이 1이므로 1을 빼줌
            let height = collectionView.frame.height - 3
            print("collectionView width=\(collectionView.frame.width)")
            print("cell하나당 width=\(width)")
            let size = CGSize(width: width, height: height)
        
            return size
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
            return 10
        }
    
}

extension BookMainViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = newBookCollection.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! BookMainCollectionViewCell
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 10
        cell.backgroundColor = .white
        
        cell.bookName.text = books[indexPath.row].title
        cell.bookDescription.text = books[indexPath.row].description
        
        if let url = URL(string: books[indexPath.row].coverSmallUrl) {
            let data = try? Data(contentsOf: url)
            cell.bookImg.image = UIImage(data: data!)
        } else {
            print("cannot conver to Data")
        }
        
        return cell
    }

}
