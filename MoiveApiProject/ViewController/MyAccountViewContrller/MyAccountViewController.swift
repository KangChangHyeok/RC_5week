//
//  MyAccountViewController.swift
//  MoiveApiProject
//
//  Created by 강창혁 on 2022/06/16.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import Kingfisher
class MyAccountViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var myEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        settingMyAccount()
        settingImageView()
    }
    
    func settingMyAccount() {
        UserApi.shared.me { user, error in
            if let error = error {
                print("사용자 정보를 불러오지 못함")
            }
            else {
                self.myName.text = user?.kakaoAccount?.profile?.nickname
                self.myEmail.text = user?.kakaoAccount?.email
                self.myImageView.kf.setImage(with: user?.kakaoAccount?.profile?.profileImageUrl)
                
            }
        }
    }

    func settingImageView() {
        self.myImageView.layer.cornerRadius = self.myImageView.frame.height / 2
        self.myImageView.layer.borderWidth = 1
        self.myImageView.layer.backgroundColor = UIColor.clear.cgColor
        self.myImageView.clipsToBounds = true
    }
    

}
