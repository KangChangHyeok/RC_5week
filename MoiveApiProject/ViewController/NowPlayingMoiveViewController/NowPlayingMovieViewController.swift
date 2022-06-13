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
    var CellNumbers = 0
    var rankList = [String]()
    var todayBoxOfficeName = [String]()
   
    
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
    @IBOutlet weak var todayBoxOfficeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingBasic()
        settingBanner()
        settingtodayBoxOfficeCollectionView()
        
        
        
    }
    //데이터를 변수에 저장
    func settingBasic() {
        dailyBoxOfficeNetWork.DailyBoxOfficeGetData { response in
            self.CellNumbers = (response?.boxOfficeResult.dailyBoxOfficeList.count)!
            
            for i in 0...9 {
                self.rankList.append((response?.boxOfficeResult.dailyBoxOfficeList[i].rank)!)
            }
            for i in 0...9 {
                self.todayBoxOfficeName.append((response?.boxOfficeResult.dailyBoxOfficeList[i].movieNm)!)
            }
            //일단 임시방편으로 reloaddata해주기
            self.bannerView.reloadData()
            self.todayBoxOfficeCollectionView.reloadData()
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

