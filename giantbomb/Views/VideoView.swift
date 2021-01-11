//
//  VideoView.swift
//  giantbomb
//
//  Created by Randeep Dhaliwal on 17/5/20.
//  Copyright © 2020 Randeep Dhaliwal. All rights reserved.
//

import SwiftUI
import AVKit
import AVFoundation

struct VideoView: View {
    @State var video: Video

    var body: some View {
        VStack(alignment: .leading) {
            VideoPlayer(urlPath: $video.lowUrl)
                .transition(.move(edge: .bottom))
                .edgesIgnoringSafeArea(.all)
            Text(video.deck)
            Text("Published: \(video.publishDate)")
            Text(video.hosts != nil ? "Cast: \(video.hosts!)" : "")
        }.padding(.all, 10.0)
        .navigationBarTitle(
            Text(video.name),
            displayMode: .inline
        )
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
            lengthSeconds: 300,
            lowUrl :"https://static-giantbombvideo.cbsistatic.com/vr/2020/05/16/328400/vf_CCC_wreckfest_1800.mp4",
            highUrl :"https://static-giantbombvideo.cbsistatic.com/vr/2020/05/16/328400/vf_CCC_wreckfest_3200.mp4",
            hdUrl :"https://static-giantbombvideo.cbsistatic.com/vr/2020/05/16/328400/vf_CCC_wreckfest_4000.mp4",
            image: VideoCoverImage()
        )
        return VideoView(video: dummyVideo)
    }
}

struct VideoPlayer: UIViewControllerRepresentable {
    @Binding var urlPath: String?

    private var player: AVPlayer {
        guard let urlPath = urlPath else { return AVPlayer() }
        let url = URL(string: "\(urlPath)?api_key=\(Environment.gbApiKey)")!
        return AVPlayer(url: url)
    }

    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {
        playerController.modalPresentationStyle = .fullScreen
        playerController.player = player
        playerController.player?.play()
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        return AVPlayerViewController()
    }
}
