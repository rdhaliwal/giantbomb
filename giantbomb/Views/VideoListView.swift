//
//  VideoListView.swift
//  giantbomb
//
//  Created by Randeep Dhaliwal on 23/5/20.
//  Copyright © 2020 Randeep Dhaliwal. All rights reserved.
//

import SwiftUI

/*
class FetchVideos: ObservableObject {
    @Published var videos: Videos

    init() {
        let videoService = VideoService()
        self.videos = Videos(results: [] as [Video])
        videoService.getVideoShows()
    }
}
*/


struct VideoListView: View {
    @ObservedObject var videos: [Videos]
    let videoService: VideoService

    init() {
        videoService = VideoService()
        videos = videoService.getVideos()
    }

    var body: some View {
        NavigationView {
            // https://medium.com/flawless-app-stories/swiftui-dynamic-list-identifiable-73c56215f9ff
            List(videos, id: \.id) { video in
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
