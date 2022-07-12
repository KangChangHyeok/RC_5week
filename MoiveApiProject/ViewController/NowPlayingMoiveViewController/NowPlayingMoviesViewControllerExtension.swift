//
//  NowPlayingMoviesViewControllerExtension.swift
//  MoiveApiProject
//
//  Created by 강창혁 on 2022/06/13.
//

import UIKit
import FSPagerView
import Alamofire


extension NowPlayingMovieViewController: FSPagerViewDataSource {
    
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 10
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = bannerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: "kakao_login_medium_narrow.png")
        return cell
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.bannerControl.currentPage = pagerView.currentIndex
    }
    
    
}

extension NowPlayingMovieViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rankList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            
            let cell = todayBoxOfficeCollectionView.dequeueReusableCell(withReuseIdentifier: "TodayBoxOfficeCell", for: indexPath) as! TodayBoxOfficeCell
            DispatchQueue.main.async {
                cell.todayBoxOfficeCellLabel.text = self.todayBoxOfficeName[indexPath.row]
                cell.todayBoxOfficeCellImageView.kf.setImage(with: URL(string: self.todayBoxOfficeImage[indexPath.row]))
            }
            
            return cell
        }
        else {
            
            let cell = todayBoxOfficeCollectionView.dequeueReusableCell(withReuseIdentifier: "WeekBoxOfficeCollectionViewCell", for: indexPath) as! WeekBoxOfficeCollectionViewCell
            DispatchQueue.main.async {
                cell.weekBoxOfficeLabel.text = self.weeklyBoxOfficeName[indexPath.row]
                cell.weekBoxOfficeImageView.kf.setImage(with: URL(string: self.todayBoxOfficeImage[indexPath.row]))
            }
            
            return cell
        }
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            let header = todayBoxOfficeCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "dailyBoxOfficeId", for: indexPath)
            return header
        } else {
            let header = todayBoxOfficeCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "weekBoxOfficeId", for: indexPath)
            
            return header
        }
        
    }
    
}

extension NowPlayingMovieViewController {
    
    class TodayBoxOfficeHeader: UICollectionReusableView {
        let label = UILabel()
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            label.text = "일간 박스오피스"
            
            addSubview(label)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            label.frame = bounds
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    class WeekBoxOfficeHeader: UICollectionReusableView {
        let label = UILabel()
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            label.text = "주간 박스오피스"
            
            addSubview(label)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            label.frame = bounds
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    
    //컴포지셔널 레이아웃 설정
    func createCompositionalLayout() -> UICollectionViewLayout {
        //컴포지셔널 레이아웃 생성
        
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) ->
            NSCollectionLayoutSection? in
            
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
                
                let groupsize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: .fractionalHeight(0.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupsize, subitem: item, count: 3)
                
                
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: "dailyBoxOffice", alignment: .topLeading)]
                
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
                
                let groupsize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: .fractionalHeight(0.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupsize, subitem: item, count: 3)
                
                
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: "weekBoxOffice", alignment: .topLeading)]
                
                return section
            }
            
            
            
        }
        return layout
    }
}

