//
//  VideoView.swift
//  giantbomb
//
//  Created by Randeep Dhaliwal on 17/5/20.
//  Copyright © 2020 Randeep Dhaliwal. All rights reserved.
//

import SwiftUI
import AVFoundation

struct VideoView: View {
    let video: Video
    var body: some View {
        VStack(alignment: .leading) {
//            Text(video.hdUrl)
            VideoPlayer(urlString: video.hdUrl)
//                .frame(width: 100.0, height: 100.0)
            Text(video.deck)
            Text("Published: \(video.publishDate)")
            Text(video.hosts != nil ? "Cast: \(video.hosts!)" : "")
        }.padding(.all, 10.0).navigationBarTitle(Text(video.name))
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
            hdUrl :"https://static-giantbombvideo.cbsistatic.com/vr/2020/05/16/328400/vf_CCC_wreckfest_4000.mp4"
        )
        return VideoView(video: dummyVideo)
    }
}


struct VideoPlayer: UIViewRepresentable {
    var urlString: String

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VideoPlayer>) {
    }

    func makeUIView(context: Context) -> UIView {
        return ViewPlayerUIView(
//            frame: CGRect(x: 100, y: 100, width: 100, height: 100),
            frame: .zero,
            urlString: urlString
        )
    }
}

class ViewPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()

    init(frame: CGRect, urlString: String) {
        super.init(frame: frame)

        let url = URL(string: "\(urlString)?api_key=\(Environment.gbApiKey)")!
        let player = AVPlayer(url: url)
        player.play()
        playerLayer.player = player
        layer.addSublayer(playerLayer)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
