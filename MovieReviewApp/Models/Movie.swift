//
//  Movie.swift
//  MovieReviewApp
//
//  Created by JeongminKim on 2022/03/17.
//

import Foundation

struct Movie: Decodable {
    let title: String
    private let image: String
    let userRating: String
    let actor: String
    let director: String
    let pubDate: String
    var imageURL: URL? { URL(string: image) }
}
