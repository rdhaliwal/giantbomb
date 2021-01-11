//
//  VideoService.swift
//  giantbomb
//
//  Created by Randeep Dhaliwal on 23/5/20.
//  Copyright © 2020 Randeep Dhaliwal. All rights reserved.
//

import Foundation

class VideoService {
    var videos: [Video] = []
    var videoShows: [VideoShow] = []

    func getVideoShows() {
        var thing = URLComponents(string: Environment.gbApiUrl)
        let path = "/api/video_shows"
        thing?.path = path
        thing?.queryItems = [
            URLQueryItem(name: "api_key", value: Environment.gbApiKey),
            URLQueryItem(name: "sort", value: "publish_date:desc"),
            URLQueryItem(name: "format", value: "json")
        ]
        guard let url = thing?.url else { return }

        let task = URLSession.shared.dataTask(with: url) {(data, response, urlError) in
            do {
                if let videoShowsData = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(VideoShows.self, from: videoShowsData)
                    DispatchQueue.main.async {
                        print(decodedData)
                        self.videoShows = decodedData.results
                    }
                } else {
                    print("No data")
                }
            } catch let decodingError {
                print("Error \(decodingError)")
            }
        }
        task.resume()
    }

    func getVideos() {
        var thing = URLComponents(string: Environment.gbApiUrl)
        let path = "/api/videos"
        thing?.path = path
        thing?.queryItems = [
            URLQueryItem(name: "api_key", value: Environment.gbApiKey),
            URLQueryItem(name: "sort", value: "publish_date:desc"),
            URLQueryItem(name: "format", value: "json")
        ]
        guard let url = thing?.url else { return }

        let task = URLSession.shared.dataTask(with: url) {(data, response, urlError) in
            do {
                if let videosData = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(Videos.self, from: videosData)
                    DispatchQueue.main.async {
                        self.videos = decodedData.results
                    }
                } else {
                    print("No data")
                }
            } catch let decodingError {
                print("Error \(decodingError)")
            }
        }
        task.resume()
    }
}
