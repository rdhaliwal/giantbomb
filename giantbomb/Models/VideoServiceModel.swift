//
//  VideoServiceModel.swift
//  giantbomb
//
//  Created by Randeep Dhaliwal on 23/5/20.
//  Copyright © 2020 Randeep Dhaliwal. All rights reserved.
//

import Foundation

struct VideoCoverImage: Decodable {
    var iconUrl: String?
    var mediumUrl: String?
    var screenUrl: String?
    var screenLargeUrl: String?
    var smallUrl: String?
    var superUrl: String?
    var thumbUrl: String?
    var tinyUrl: String?
}

struct Video : Decodable, Identifiable {
    var id: Int
    var guid: String
    var name: String
    var deck: String
    var hosts: String?
    var publishDate: String
    var premium: Bool
    var lengthSeconds: Int
    var lowUrl: String?
    var highUrl: String?
    var hdUrl: String?
    var image: VideoCoverImage
}

struct Videos : Decodable {
    var results: [Video]
}

struct VideoShow : Decodable, Identifiable {
    var id: Int
    var guid: String
    var title: String
    var latest: [Video]
    var premium: Bool
    var image: VideoCoverImage
}

struct VideoShows : Decodable {
    var results: [VideoShow]
}

