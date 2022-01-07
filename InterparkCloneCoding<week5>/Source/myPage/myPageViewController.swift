//
//  myPageViewController.swift
//  InterparkCloneCoding<week5>
//
//  Created by 정지윤 on 2021/12/23.
//

import Foundation
import UIKit
import KakaoSDKUser

class myPageViewController : UIViewController{
    
    let ud = UserDefaults.standard
    
    var loginCheck = false
    var userName = "방문자"
    var userImg = UIImage(named: "userDefaultImg")
    
    
    @IBOutlet weak var userNameView: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    
    @IBOutlet weak var logInOrOut: UIButton!
    @IBAction func logInOrOutBtn(_ sender: Any) {
        
        if !self.loginCheck{
            // 로그인 화면 띄우기
            guard let lvc = self.storyboard?.instantiateViewController(withIdentifier: "loginView") as? LoginViewController else {return}
            
            lvc.modalPresentationStyle = .overCurrentContext
            present(lvc, animated: true)
            
        } else{
            // 연결 끊기 - 로그아웃 포함
            UserApi.shared.unlink {(error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("logout() success.")

                }
            }
            
            //UserDefaults 초기화
            for key in UserDefaults.standard.dictionaryRepresentation().keys {
                UserDefaults.standard.removeObject(forKey: key.description)
            }
            
            
            guard let lvc = storyboard?.instantiateViewController(withIdentifier: "loginView") as? LoginViewController else {return}
            
            lvc.setUserInfo()
            
            return
        }
        
    }
    

    
    func initializeView() {
        
            
        self.loginCheck = self.ud.bool(forKey: "loginCheck")
        if let name = self.ud.string(forKey: "name"){
            self.userName = name
        }
        if let data = self.ud.data(forKey: "img"){
            self.userImg = UIImage(data: data)
        }
        
        
        self.userNameView.text = self.userName
        self.userImageView.image = self.userImg
        
        
        if self.loginCheck{
            self.logInOrOut.setTitle("로그아웃 하기", for: .normal)
        } else {
            self.logInOrOut.setTitle("로그인 하기", for: .normal)
        }
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initializeView()
        
    }
    
}
