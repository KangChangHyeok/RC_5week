//
//  MovieSearchViewController.swift
//  MoiveApiProject
//
//  Created by 강창혁 on 2022/06/14.
//

import UIKit
import Alamofire
import Kingfisher
class MovieSearchViewController: UIViewController {
    
    @IBOutlet weak var movieSearchTextField: UITextField!
    @IBOutlet weak var moiveSearchCollectionView: UICollectionView!
    var searchMovieImage = [String]()
    var searchMovieTitle = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moiveSearchCollectionView.dataSource = self
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        
        let urlString = "https://openapi.naver.com/v1/search/movie"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "nwrCcKyomkzfe_UmrH1d",
            "X-Naver-Client-Secret": "uKpue2GMA7"
        ]
        let searchText : Parameters = [
            "query": movieSearchTextField.text!
        ]
        
        AF.request(urlString, method: .get,parameters: searchText, headers: header)
            .responseDecodable(of: Movie.self) { searchResult in
                switch searchResult.result {
                case .success(_):
                    print("통신 성공!")
                    guard let moivedata = searchResult.value else {return}
                        self.searchMovieImage.removeAll()
                        self.searchMovieTitle.removeAll()
                    for i in 0...moivedata.display - 1 {
                        self.searchMovieImage.append(moivedata.items[i].image)
                    }
                    for i in 0...moivedata.display - 1 {
                        self.searchMovieTitle.append(moivedata.items[i].title.htmlEscaped)
                    }
                    
                case .failure(_):
                    print("통신 오류")
                    break
                }
                self.moiveSearchCollectionView.reloadData()
                
            }
        
       
        
    }
}

extension MovieSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchMovieTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.moiveSearchCollectionView.dequeueReusableCell(withReuseIdentifier: "MoiveSearchCollectionViewCell", for: indexPath) as! MoiveSearchCollectionViewCell
        cell.movieSearchImageView.kf.setImage(with: URL(string: self.searchMovieImage[indexPath.row]))
        cell.movieSearchTitle.text = searchMovieTitle[indexPath.row]
        return cell
        
    }
    
    
}



extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}

extension String {
    // html 태그 제거 + html entity들 디코딩.
    var htmlEscaped: String {
        guard let encodedData = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributed = try NSAttributedString(data: encodedData,
                                                    options: options,
                                                    documentAttributes: nil)
            return attributed.string
        } catch {
            return self
        }
    }
}
