//
//  recommendViewController.swift
//  InterparkCloneCoding<week5>
//
//  Created by 정지윤 on 2021/12/23.
//

import Foundation
import UIKit

class RecommendViewController : BaseViewController {
    
    lazy var dataManager: BookDataManager = BookDataManager()
    var books : [Book] = []

    
    @IBOutlet weak var recommendations: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recommendations.delegate = self
        self.recommendations.dataSource = self
        
        recommendations.backgroundColor = . lightGray
        
        self.showIndicator()
        dataManager.searchRecommendBooks(categoryId: "100", urlType: "recommend", delegate: self)
        
    }
}

extension RecommendViewController {
    
    func didRetrieveBooks(result: [Book]) { //책의 내용을 통째로 받아온 후, 테이블 뷰 Or 셀 클릭했을 때 뿌려줄 정보 나누어서 각자 뿌려준다.
        self.dismissIndicator()
        
        for i in 0..<15 {
            
            books.append(result[i])
            
        }
        recommendations.reloadData() //데이터를 받아와서 셀에 띄울 때 -> 데이터가 변경될 떄 사용
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}


extension RecommendViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        //셀 크기
        let width = collectionView.frame.width / 2 - 10.5
        let height = width / 2 * 3
        print("collectionView width=\(collectionView.frame.width)")
        print("cell하나당 width=\(width)")
        let size = CGSize(width: width, height: height)
    
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
            return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
            return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    }
}


extension RecommendViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "reusableView", for: indexPath) as? SectionHeader{
                
                headerView.sectionHeaderlabel.text = "인터파크 추천"
                return headerView
            }

        default:
            return UICollectionReusableView()
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = 70
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recommendations.dequeueReusableCell(withReuseIdentifier: "recommendCell", for: indexPath) as! RecommendCollectionViewCell
        
    
        cell.backgroundColor = .white
        
        cell.bookName.text = "\(books[indexPath.row].title)"
        cell.authorAndPublisher.text = "\(books[indexPath.row].author) | \(books[indexPath.row].publisher)"
        
        if let url = URL(string: books[indexPath.row].coverLargeUrl) {
            let data = try? Data(contentsOf: url)
            cell.bookImg.image = UIImage(data: data!)
        } else {
            print("cannot conver to Data")
        }
        
        
        return cell
    }
    
    
}
