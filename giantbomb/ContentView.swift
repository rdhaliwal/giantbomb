//
//  ContentView.swift
//  giantbomb
//
//  Created by Randeep Dhaliwal on 17/5/20.
//  Copyright © 2020 Randeep Dhaliwal. All rights reserved.
//

import SwiftUI

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

class FetchVideos: ObservableObject {
    @Published var videos: Videos

    init() {
        self.videos = Videos(results: [] as [Video])

        var thing = URLComponents(string: Environment.gbApiUrl)
        let path = "/api/videos"
        thing?.path = path
        thing?.queryItems = [
            URLQueryItem(name: "api_key", value: Environment.gbApiKey),
            URLQueryItem(name: "sort", value: "publish_date:desc"),
            URLQueryItem(name: "format", value: "json")
        ]
        guard let url = thing?.url else { return }

        URLSession.shared.dataTask(with: url) {(data, response, urlError) in
            do {
                if let videosData = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(Videos.self, from: videosData)
                    DispatchQueue.main.async {
                        self.videos = decodedData
                    }
                } else {
                    print("No data")
                }
            } catch let decodingError {
                print("Error \(decodingError)")
            }
        }.resume()
    }
}


struct ContentView: View {
    @ObservedObject var fetchVideos = FetchVideos()

    var body: some View {
        NavigationView {
            List(fetchVideos.videos.results) { video in
                NavigationLink(destination: VideoView(video: video)) {
                    HStack(alignment: .top) {
                        Text(video.premium ? "[P]" : "")
                        Text(video.name)
                    }
                }
            }
            .navigationBarTitle(Text("Latest Videos"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
