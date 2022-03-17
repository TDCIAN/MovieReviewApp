//
//  Movie.swift
//  MovieReviewApp
//
//  Created by JeongminKim on 2022/03/17.
//

import Foundation

struct Movie: Codable {
    let title: String
    private let image: String
    let userRating: String
    let actor: String
    let director: String
    let pubDate: String
    
    var isLiked: Bool
    var imageURL: URL? { URL(string: image) }
    
    private enum CodingKeys: String, CodingKey {
        case title, image, userRating, actor, director, pubDate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? "-"
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        userRating = try container.decodeIfPresent(String.self, forKey: .userRating) ?? "-"
        actor = try container.decodeIfPresent(String.self, forKey: .actor) ?? "-"
        director = try container.decodeIfPresent(String.self, forKey: .director) ?? "-"
        pubDate = try container.decodeIfPresent(String.self, forKey: .pubDate) ?? "-"
        
        isLiked = false
    }
    
    init(
        title: String,
        imageURL: String,
        userRating: String,
        actor: String,
        director: String,
        pubDate: String,
        isLiked: Bool = false
    ) {
        self.title = title
        self.image = imageURL
        self.userRating = userRating
        self.actor = actor
        self.director = director
        self.pubDate = pubDate
        self.isLiked = isLiked
    }
}
