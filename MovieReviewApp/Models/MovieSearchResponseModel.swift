//
//  MovieSearchResponseModel.swift
//  MovieReviewApp
//
//  Created by JeongminKim on 2022/03/17.
//

import Foundation

struct MovieSearchResponseModel: Decodable {
    var items: [Movie] = []
}
