//
//  VideoListView.swift
//  giantbomb
//
//  Created by Randeep Dhaliwal on 23/5/20.
//  Copyright © 2020 Randeep Dhaliwal. All rights reserved.
//

import SwiftUI

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


struct VideoListView: View {
    @ObservedObject var fetchVideos = FetchVideos()

    var body: some View {
        NavigationView {
            // https://medium.com/flawless-app-stories/swiftui-dynamic-list-identifiable-73c56215f9ff
            List(fetchVideos.videos.results, id: \.id) { video in
                NavigationLink(destination: VideoView(video: video)) {
                    HStack(alignment: .center) {
                        if video.premium {
                            Image(systemName: "star.fill")
                        }
                        Text(video.name)
                    }
                }
            }//.id(UUID())

            .navigationBarTitle(Text("Latest Videos"))
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct VideoListView_Previews: PreviewProvider {
    static var previews: some View {
        VideoListView()
    }
}

// Potential way to improve the semantics of conditional views
// https://stackoverflow.com/a/57685253
