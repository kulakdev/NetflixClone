//
//  MovieModel.swift
//  NetflixClone
//
//  Created by Macbook Pro on 28.01.2024.
//

import Foundation

struct TrendingMoviesResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let backdropPath: String?
    let mediaType: String?
    let originalName: String?
    let originalTitle: String?
    let overview: String?
    let releaseDate: String?
    let voteCount: Int?
    let voteAverage: Float?
}
