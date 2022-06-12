//
//  TabBarViewControllerExtension.swift
//  MoiveApiProject
//
//  Created by 강창혁 on 2022/06/12.
//

import Foundation
import UIKit
import Pageboy
import Tabman

extension TabBarViewController: PageboyViewControllerDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

extension TabBarViewController: TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "Now Playing")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }
    }
    
    
}
