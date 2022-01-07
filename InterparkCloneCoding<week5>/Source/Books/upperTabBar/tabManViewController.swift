//
//  bookMainViewController.swift
//  InterparkCloneCoding<week5>
//
//  Created by 정지윤 on 2021/12/23.
//

import Foundation
import UIKit
import Tabman
import Pageboy

class tabManViewController : TabmanViewController{
    
    var viewControllers: Array<UIViewController> = []
    var tabTitles : Array<String> = ["홈", "베스트셀러", "지금!추천", "음반/DVD"]
    
    @IBOutlet weak var tempView: UIView! // 상단 탭바 들어갈 자리
    
    
    func settingTabBar(ctBar: TMBar.ButtonBar) {
        //바 설정
        ctBar.layout.transitionStyle = .snap
        ctBar.backgroundView.tintColor = .white
        ctBar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 15.0)
//        ctBar.layout.interButtonSpacing = 25
        ctBar.layout.alignment = .centerDistributed // .center시 선택된 탭이 가운데로 오게 됨.
        ctBar.layout.contentMode = .fit
        
        //버튼 설정
        ctBar.buttons.customize { (button) in
            button.tintColor = .darkGray
            button.selectedTintColor = .black
            button.font = UIFont.systemFont(ofSize: 16)
            button.selectedFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        }
        
        //인디케이터 설정
        ctBar.indicator.weight = .custom(value: 2)
        ctBar.indicator.tintColor = .red
        ctBar.indicator.overscrollBehavior = .compress

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        let vc1 = UIStoryboard.init(name: "Books", bundle: nil).instantiateViewController(withIdentifier: "bookMainView") as! BookMainViewController
        let vc2 = UIStoryboard.init(name: "Books", bundle: nil).instantiateViewController(withIdentifier: "bestsellerView") as! BestSellerViewController
        let vc3 = UIStoryboard.init(name: "Books", bundle: nil).instantiateViewController(withIdentifier: "recommendView") as! RecommendViewController
        let vc4 = UIStoryboard.init(name: "Books", bundle: nil).instantiateViewController(withIdentifier: "albumView") as! AlbumViewController
        
        viewControllers.append(vc1)
        viewControllers.append(vc2)
        viewControllers.append(vc3)
        viewControllers.append(vc4)
        
        self.dataSource = self

        // Create & Customize bar
        let bar = TMBar.ButtonBar()
        settingTabBar(ctBar: bar)
        
        // Add to view
        addBar(bar, dataSource: self, at: .custom(view: tempView, layout: nil))
    }
}

extension tabManViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        item.title = tabTitles[index]
        
        return item
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
