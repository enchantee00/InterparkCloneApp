//
//  ViewController.swift
//  InterparkCloneCoding<week5>
//
//  Created by 정지윤 on 2021/12/23.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class LoginViewController: UIViewController {
    
    @IBOutlet weak var TestImg: UIImageView!
    
    
    
    let ud = UserDefaults.standard
    
    //Default -> 로그인 정보 없을 때
//    var infoLabel = "방문자"
//    var profileImageView = UIImage(named: "userDefaultImg")
//    var loginCheck = false

    
    @IBOutlet weak var socialLoginBtn: UIButton!
    @IBAction func onKakaoLoginByAppTouched(_ sender: Any) {
        
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
           if let error = error {
             print(error)
           }
           else {
               print("loginWithKakaoAccount() success.")
               //do something
               _ = oauthToken
               
               // 어세스토큰
               let accessToken = oauthToken?.accessToken
               
               //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
               self.setUserInfo()
           }
        }
    }
    
    func setUserInfo() {
        //사용자 관리 api 호출
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                //do something
                _ = user
                 
                
                if let userNickname = user?.kakaoAccount?.profile?.nickname{
                    print(userNickname)
                
                    self.ud.set(userNickname, forKey: "name")
                    self.ud.set(true, forKey: "loginCheck")
                    
                    
                } else {
                    print("couldn't load the nickname")
                    self.ud.set("방문자", forKey: "name")
                    self.ud.set(false, forKey: "loginCheck")

                }
                
                                
                
                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
                    let data = try? Data(contentsOf: url) {
                    print("success")
                    
                    self.ud.set(data, forKey: "img")
                    
                } else {
                    
                    let data = Data("userDefaultImg".utf8)
                    self.ud.set(data ,forKey: "img")
                    print("couldn't load the image")
                }
                
                
                //홈 화면 루트뷰로 설정
                let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "rootView")
                self.changeRootViewController(mainTabBarController)
                
            }
        }
    }
    
    
    @IBAction func closeViewBtn(_ sender: Any) {
        
        // 홈 화면 루트뷰로 설정(방문자 상태)
        let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "rootView")
        self.changeRootViewController(mainTabBarController)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let url = URL(string: "https://yaimg.yanolja.com/resize/place/v4/2017/08/23/14/1280/599d160ab30c00.19752238.jpg") {
            
            let data = try? Data(contentsOf: url)
            TestImg.image = UIImage(data: data!)
        }
        
        
    }
}

// 1. 로그인 화면 -> 그냥 끌 때
// 2. 로그인 화면 -> 로그인 할 때
// 3. 홈 화면
// 4. 홈 화면 -> 로그아웃 할 때
