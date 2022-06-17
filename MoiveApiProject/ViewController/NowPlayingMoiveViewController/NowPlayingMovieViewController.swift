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
    
    let dailyBoxOfficeNetWork = DailyBoxOfficeNetWork()
    let weeklyBoxOfficeNetWork = WeeklyBoxOfficeNetWork()
    let imageManager = ImageManager()
    var CellNumbers = 0
    var rankList = [String]()
    var todayBoxOfficeName = [String]()
    var todayBoxOfficeImage = [String]()
    var weeklyBoxOfficeName = [String]()
    var weeklyBoxOfficeImage = [String]()
    
    //FspagerView 변수 세팅
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
            self.bannerControl.numberOfPages = 10
            self.bannerControl.contentHorizontalAlignment = .center
            
            self.bannerControl.itemSpacing = 16
            self.bannerControl.interitemSpacing = 16
            self.bannerControl.backgroundColor = .clear
        }
    }
    @IBOutlet weak var todayBoxOfficeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingBasic()
        self.settingBanner()
        self.settingtodayBoxOfficeCollectionView()
    }
    //데이터 받아와서 사용할 변수나 리스트에 저장
    func settingBasic() {
        DispatchQueue.global().async {
            self.dailyBoxOfficeNetWork.DailyBoxOfficeGetData { response in
                guard let nonoptionalresponse = response else {return}
                self.CellNumbers = (nonoptionalresponse.boxOfficeResult.dailyBoxOfficeList.count)
                for i in 0...9 {
                    self.rankList.append(nonoptionalresponse.boxOfficeResult.dailyBoxOfficeList[i].rank)
                }
                for i in 0...9 {
                    self.todayBoxOfficeName.append(nonoptionalresponse.boxOfficeResult.dailyBoxOfficeList[i].movieNm)
                    self.imageManager.settingImage(title: self.todayBoxOfficeName[i]) { url in
                        self.todayBoxOfficeImage.append(url)
                    }
                }
                
            }
            
        }
        
        
        DispatchQueue.main.async {
            self.bannerView.reloadData()
        }
        
        
        self.weeklyBoxOfficeNetWork.WeeklyBoxOfficeGetData { response in
            guard let nonopotionalresponse = response else {return}
            for i in 0...9 {
                self.weeklyBoxOfficeName.append(nonopotionalresponse.boxOfficeResult.weeklyBoxOfficeList[i].movieNm)
            }
            DispatchQueue.main.async {
                self.todayBoxOfficeCollectionView.reloadData()
            }
        }
    }
func settingBanner() {
    self.bannerView.dataSource = self
    self.bannerView.delegate = self
}
func settingtodayBoxOfficeCollectionView() {
    self.todayBoxOfficeCollectionView.dataSource = self
    self.todayBoxOfficeCollectionView.collectionViewLayout = createCompositionalLayout()
    self.todayBoxOfficeCollectionView.register(TodayBoxOfficeHeader.self, forSupplementaryViewOfKind: "dailyBoxOffice", withReuseIdentifier: "dailyBoxOfficeId")
    self.todayBoxOfficeCollectionView.register(WeekBoxOfficeHeader.self, forSupplementaryViewOfKind: "weekBoxOffice", withReuseIdentifier: "weekBoxOfficeId")
}


}
