//
//  Album.swift
//  PacelineDemo
//
//  Created by Jonathan  Fotland on 7/24/22.
//

import Foundation

struct AlbumData: Decodable {
    var title: String
    var albums: [Album]
    
    enum CodingKeys: String, CodingKey {
        case feed
    }
    
    enum FeedKeys: String, CodingKey {
        case title
        case albums = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let feedContainer = try container.nestedContainer(keyedBy: FeedKeys.self, forKey: .feed)
        title = try feedContainer.decode(String.self, forKey: .title)
        albums = try feedContainer.decode([Album].self, forKey: .albums)
    }
}

struct Album: Codable {
    
    var name: String
    var artist: String
    var imgURL: String
    var genres: [Genre]
    var releaseDate: String
    var copyright: String
    var itunesURL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case artist = "artistName"
        case imgURL = "artworkUrl100"
        case genres
        case releaseDate
        case copyright
        case itunesURL = "url"
    }
}

struct Genre: Codable {
    var genreId: String
    var name: String
    var url: String
}
