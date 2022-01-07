//
//  SceneDelegate.swift
//  InterparkCloneCoding<week5>
//
//  Created by 정지윤 on 2021/12/23.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var check : Bool = false
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
//        if check {
//
//            guard let lvc = self.storyboard.instantiateViewController(withIdentifier: "loginView") as? loginViewController else {return}
//            window?.rootViewController = lvc
//        } else {
//
//            guard let hvc = self.storyboard.instantiateViewController(withIdentifier: "rootView") as? UITabBarController else {return}
//            window?.rootViewController = hvc
//        }
//
        
        //로그인 했는지 체크
        if (AuthApi.hasToken()) { // 로그인 정보 있음
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                    }
                    else {
                        //기타 에러
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)

                    let lvc = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateViewController(withIdentifier: "loginView") as? LoginViewController
                    // ✅ 사용자 정보를 가져오고 화면전환을 하는 커스텀 메서드
                    lvc!.setUserInfo()

                }
            }
        }
        else { //로그인 정보 없음
            //로그인 화면 띄우기
            let lvc = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateViewController(withIdentifier: "loginView")
            
            changeRootViewController(lvc, animated: true)      }
    }
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func changeRootViewController (_ vc: UIViewController, animated: Bool) {

        guard let window = self.window else { return }
        window.rootViewController = vc // 전환

        UIView.transition(with: window, duration: 0.4, options: [.transitionCrossDissolve], animations: nil, completion: nil)

    }

}
