//
//  ImageManager.swift
//  MoiveApiProject
//
//  Created by 강창혁 on 2022/06/17.
//

import UIKit
import Alamofire
class ImageManager {
    
    func settingImage(title: String, completion: @escaping (String) -> Void) {
        let urlString = "https://openapi.naver.com/v1/search/movie"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "nwrCcKyomkzfe_UmrH1d",
            "X-Naver-Client-Secret": "uKpue2GMA7"
        ]
        let text : Parameters = [
            "query": title
        ]
        
        AF.request(urlString, method: .get,parameters: text, headers: header)
            .responseDecodable(of: Movie.self) { searchResult in
                switch searchResult.result {
                case .success(_):
                    print("통신 성공!")
                    guard let moivedata = searchResult.value else {return}
                    print(moivedata.items[0].title)
                    completion(moivedata.items[0].image)
                case .failure(_):
                    print("통신 오류")
                    break
                }
            }
    }
}
