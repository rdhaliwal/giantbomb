//
//  VideoView.swift
//  giantbomb
//
//  Created by Randeep Dhaliwal on 17/5/20.
//  Copyright © 2020 Randeep Dhaliwal. All rights reserved.
//

import SwiftUI

struct VideoView: View {
    let video: Video
    var body: some View {
        VStack {
            Text(video.deck)
            Text("Published: \(video.publishDate)")
            Text(video.hosts != nil ? "Cast: \(video.hosts!)" : "")
        }.navigationBarTitle(Text(video.name))
    }

}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyVideo: Video = Video(
            id: 1,
            guid: "guid",
            name: "something",
            deck: "deck",
            hosts: "randeep",
            publishDate: "2020-05-16 13:44:00",
            premium: true,
            lengthSeconds: 300
        )
        return VideoView(video: dummyVideo)
    }
}
