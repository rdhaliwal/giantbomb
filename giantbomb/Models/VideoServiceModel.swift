//
//  VideoServiceModel.swift
//  giantbomb
//
//  Created by Randeep Dhaliwal on 23/5/20.
//  Copyright © 2020 Randeep Dhaliwal. All rights reserved.
//

import Foundation

struct Video : Decodable, Identifiable {
    var id: Int
    var guid: String
    var name: String
    var deck: String
    var hosts: String?
    var publishDate: String
    var premium: Bool
    var lengthSeconds: Int
    var lowUrl: String
    var highUrl: String
    var hdUrl: String
}

struct Videos : Decodable {
    var results: [Video]
}

