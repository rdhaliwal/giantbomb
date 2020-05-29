//
//  ContentView.swift
//  giantbomb
//
//  Created by Randeep Dhaliwal on 29/5/20.
//  Copyright © 2020 Randeep Dhaliwal. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            VideoListView()
                .tabItem {
                    Image(systemName: "tv.fill")
                    Text("Videos")
            }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
