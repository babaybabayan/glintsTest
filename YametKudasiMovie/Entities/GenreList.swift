//
//  GenreList.swift
//  YametKudasiMovie
//
//  Created by AkbarPuteraW on 19/09/21.
//

import Foundation

// MARK: - Welcome
struct GenreList: Codable {
    var genres: [Genres]
}

// MARK: - Genre
struct Genres: Codable {
    var id: Int
    var name: String
}
