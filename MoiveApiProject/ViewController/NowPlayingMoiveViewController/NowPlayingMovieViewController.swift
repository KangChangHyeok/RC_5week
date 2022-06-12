//
//  NowPlayingMovieViewController.swift
//  MoiveApiProject
//
//  Created by 강창혁 on 2022/06/12.
//

import UIKit
import FSPagerView
import Alamofire
class NowPlayingMovieViewController: UIViewController, FSPagerViewDelegate {
    
    
    @IBOutlet weak var bannerView: FSPagerView! {
        didSet {
            self.bannerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.bannerView.itemSize = FSPagerView.automaticSize
            self.bannerView.isInfinite = true
            self.bannerView.automaticSlidingInterval = 3.0
        }
    }
    @IBOutlet weak var bannerControl: FSPageControl! {
        didSet {
            self.bannerControl.numberOfPages = 1
            self.bannerControl.contentHorizontalAlignment = .right
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bannerView.dataSource = self
        self.bannerView.delegate = self
        //요 부분!
        networktest()
        let urlString = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
        let key = "key=b04bd0c57030c4310986c8107ae4ec02"
        let others = "&targetDt=20220101"
        AF.request(urlString + key + others)
            .response { response in
            switch response.result {
            case .success(_):
                print("성공")
            case .failure(_):
                print("실패")
            }
        }
            
          
    }
    
    func networktest() {
         
        }
    }

    extension NowPlayingMovieViewController: FSPagerViewDataSource {
        func numberOfItems(in pagerView: FSPagerView) -> Int {
            return 1
        }
        
        func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
            let cell = bannerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
            cell.imageView?.image = UIImage(named: "kakao_login_medium_narrow.png")
            return cell
        }
        
        
    }
    
