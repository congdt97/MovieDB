//
//  MovieModel.swift
//  MoviDB
//
//  Created by Apple on 7/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieModel: Mappable {
    
    var page: Int?
    var total_results: Int?
    var total_pages: Int?
    var results: [Result]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.page <- map["page"]
        self.total_results <- map["total_results"]
        self.total_pages <- map["total_pages"]
        self.results <- map["results"]
    }
}

class Result: Mappable {
    var popularity: Float?
    var vote_count: Int?
    var video: Bool?
    var poster_path: String?
    var id : Int?
    var adult: Bool?
    var backdrop_path: String?
    var original_language: String?
    var original_title: String?
    var genre_ids: [Int]?
    var title: String?
    var vote_average: Float?
    var overview: String?
    var release_date: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.popularity <- map["popularity"]
        self.vote_count <- map["vote_count"]
        self.video <- map["video"]
        self.poster_path <- map["poster_path"]
        self.id <- map["id"]
        self.adult <- map["adult"]
        self.backdrop_path <- map["backdrop_path"]
        self.original_language <- map["original_language"]
        self.original_title <- map["original_title"]
        self.genre_ids <- map["genre_ids"]
        self.title <- map["title"]
        self.vote_average <- map["vote_average"]
        self.overview <- map["overview"]
        self.release_date <- map["release_date"]
    }
}
