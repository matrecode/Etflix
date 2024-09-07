//
//  MovieModel.swift
//  Setflix
//
//  Created by Hemant Rajkumar Pancheshwar on 05/09/24.
//

import Foundation

struct MovieModel: Codable, Identifiable {
    let id = UUID() // Temporary ID since the API doesn't provide unique IDs
    let title: String
    let year: String
    let poster: String
    var isFavourite: Bool = false

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case poster = "Poster"
    }
}
