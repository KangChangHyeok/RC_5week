//
//  WeekBoxOfficeNetWork.swift
//  MoiveApiProject
//
//  Created by 강창혁 on 2022/06/14.
//

import Foundation
import Alamofire

class WeeklyBoxOfficeNetWork {
    
    func WeeklyBoxOfficeGetData(completion: @escaping (WeeklyBoxOfficeData?) -> Void) {
        let baseUrl = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?"
        let key = "key=b04bd0c57030c4310986c8107ae4ec02"
        
        let date = Date(timeIntervalSinceNow: -86400*7)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        dateFormatter.dateFormat = "YYYYMMdd"
        let today = dateFormatter.string(from: date)
        
        let others = "&targetDt=\(today)&weekGb=0"
        // 메소드 체이닝
        // 탈출 클로져
        // Codable Protocol
        
        // 메소드 체이닝
        AF.request(baseUrl + key + others)
            .responseDecodable(of: WeeklyBoxOfficeData.self) { response in
                print("주간 박스오피스 데이터 받음")
                switch response.result { // RESULT
                case .success(_):
                    guard let successResponse = response.value else { return }
                    
                    completion(successResponse)
                    
                case .failure(_):
                    completion(nil)
                    print("error")
                    break
                }
            }
    }
}
