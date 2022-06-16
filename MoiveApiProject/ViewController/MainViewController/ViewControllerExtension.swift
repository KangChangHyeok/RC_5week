//
//  ViewControllerExtension.swift
//  MoiveApiProject
//
//  Created by 강창혁 on 2022/06/12.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

extension ViewController {
    
    //카카오 로그인
    func kakaoLoign() {
        UserApi.shared.loginWithKakaoAccount { [self](oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    
                    tabBarVCPresent()
                    _ = oauthToken
                }
            }
    }
    
    //로그인화면 -> 메인화면
    func tabBarVCPresent() {
        let TabBarVC = self.storyboard?.instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
        TabBarVC.modalTransitionStyle = .crossDissolve
        TabBarVC.modalPresentationStyle = .overFullScreen
        self.present(TabBarVC, animated: true, completion: nil)
    }
    
    
}
