//
//  BoxOfficeViewController.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import UIKit

class BestSellerViewController: BaseViewController {
    lazy var dataManager: BookDataManager = BookDataManager()
    
    
    @IBOutlet weak var BestSellerTableView: UITableView!
    
    var books : [BestSellerBook] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table View
        BestSellerTableView.delegate = self
        BestSellerTableView.dataSource = self
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 600))
        
        header.backgroundColor = .white
        footer.backgroundColor = .darkGray
        
        BestSellerTableView.tableHeaderView = header
        
        // Request Books
        self.showIndicator()
        dataManager.searchBestSellerBooks(categoryId: "100", urlType: "bestSeller", delegate: self)
    }
    
    // 셀 클릭했을 때 화면 넘어가기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BestSellerTableViewCellSegue",
           let bookInfoViewController = segue.destination as? BSBookViewController,
           let cell = sender as? UITableViewCell,
           let indexPath = BestSellerTableView.indexPath(for: cell) {
            let book = books[indexPath.row]
            bookInfoViewController.book = book
        }
    }
}

extension BestSellerViewController {
    func didRetrieveBooks(result: [BestSellerBook]) { //책의 내용을 통째로 받아온 후, 테이블 뷰 Or 셀 클릭했을 때 뿌려줄 정보 나누어서 각자 뿌려준다.
        self.dismissIndicator()
        
        for i in 0..<15 {
            
            books.append(result[i])
            
        }
        BestSellerTableView.reloadData() //데이터를 받아와서 셀에 띄울 때 -> 데이터가 변경될 떄 사용
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}


//CollectionView관리
extension BestSellerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BestSellerTableView.dequeueReusableCell(withIdentifier: "BestSellerTableViewCell", for: indexPath) as! BestSellerCell
        
        // 셀 클릭 못 하게 -> 선택했을 때 회색으로 변하는 현상 방지
        cell.selectionStyle = .none
        
        switch books[indexPath.row].rank{

        case 1:
            cell.rank.textColor = .red
            cell.rank.font = UIFont.boldSystemFont(ofSize: 27.0)
        case 2, 3:
            cell.rank.textColor = .red
        default :
            cell.rank.font = UIFont.systemFont(ofSize: 25.0)
        }
        
        cell.rank.text = "\(books[indexPath.row].rank)"
        cell.bookName.text = books[indexPath.row].title
        cell.authorName.text = books[indexPath.row].author
        cell.reviewCount.text = "\(books[indexPath.row].reviewCount)"
        
        if let url = URL(string: books[indexPath.row].coverSmallUrl) {
            let data = try? Data(contentsOf: url)
            cell.bookImg.image = UIImage(data: data!)
        } else {
            print("cannot conver to Data")
        }
        
        return cell
    }
    
}

