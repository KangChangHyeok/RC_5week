//
//  WeekBoxOfficeData.swift
//  MoiveApiProject
//
//  Created by 강창혁 on 2022/06/14.
//

import Foundation

// MARK: - WeeklyBoxOfficeData
struct WeeklyBoxOfficeData: Codable {
    let boxOfficeResult: WeeklyBoxOfficeResult
}

// MARK: - BoxOfficeResult
struct WeeklyBoxOfficeResult: Codable {
    let boxofficeType, showRange, yearWeekTime: String
    let weeklyBoxOfficeList: [WeeklyBoxOfficeList]
}

// MARK: - WeeklyBoxOfficeList
struct WeeklyBoxOfficeList: Codable {
    let rnum, rank, rankInten: String
    let rankOldAndNew: WeeklyRankOldAndNew
    let movieCD, movieNm, openDt, salesAmt: String
    let salesShare, salesInten, salesChange, salesAcc: String
    let audiCnt, audiInten, audiChange, audiAcc: String
    let scrnCnt, showCnt: String

    enum CodingKeys: String, CodingKey {
        case rnum, rank, rankInten, rankOldAndNew
        case movieCD = "movieCd"
        case movieNm, openDt, salesAmt, salesShare, salesInten, salesChange, salesAcc, audiCnt, audiInten, audiChange, audiAcc, scrnCnt, showCnt
    }
}

enum WeeklyRankOldAndNew: String, Codable {
    case new = "NEW"
    case old = "OLD"
}
