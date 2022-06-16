//
//  TabBarViewController.swift
//  MoiveApiProject
//
//  Created by 강창혁 on 2022/06/12.
//

import UIKit
import Tabman
import Pageboy

class TabBarViewController: TabmanViewController {
    
    
    
    var viewControllers : [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
        settingtabBar()
        
        
    }
    func createTabBar() {
        let nowPlayingMovieVC = self.storyboard?.instantiateViewController(identifier: "NowPlayingMovieViewController") as! NowPlayingMovieViewController
        let moiveSearchVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieSearchViewController") as! MovieSearchViewController
        let myAccountVC = self.storyboard?.instantiateViewController(withIdentifier: "MyAccountViewController") as! MyAccountViewController
        viewControllers.append(nowPlayingMovieVC)
        viewControllers.append(moiveSearchVC)
        viewControllers.append(myAccountVC)
        
        self.dataSource = self
        
        let TabBar = TMBar.ButtonBar()
        TabBar.scrollMode = .none
        addBar(TabBar, dataSource: self, at: .top)
    }
    func settingtabBar() {
        //탭바 아이템 및 전체적인 디자인 커스텀 나중에 하기
    }
    
}




