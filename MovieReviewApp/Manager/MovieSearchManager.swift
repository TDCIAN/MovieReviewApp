//
//  MovieSearchManager.swift
//  MovieReviewApp
//
//  Created by JeongminKim on 2022/03/17.
//

import Foundation
import Alamofire

// Test를 위해 필요한 Mock을 생성하기 위해서는 프로토콜을 추가하는 것이 좋다
protocol MovieSearchManagerProtocol {
    func request(from keyword: String, completionHandler: @escaping ([Movie]) -> Void)
}

struct MovieSearchManager: MovieSearchManagerProtocol {
    func request(from keyword: String, completionHandler: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/movie.json") else { return }
        
        let parameters = MovieSearchRequestModel(query: keyword)
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "gxg5FUsGBBL3VqwT8C88",
            "X-Naver-Client-Secret": "KeKGMRmjwk"
        ]
        
        AF.request(
            url,
            method: .get,
            parameters: parameters,
            headers: headers
        )
        .responseDecodable(of: MovieSearchResponseModel.self) { response in
            switch response.result {
            case .success(let result):
                completionHandler(result.items)
            case .failure(let error):
                print("MovieSearchManager - error: \(error)")
            }
        }
        .resume()
    }
}
