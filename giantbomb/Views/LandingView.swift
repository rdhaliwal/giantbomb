//
//  LandingView.swift
//  giantbomb
//
//  Created by Randeep Dhaliwal on 7/7/20.
//  Copyright © 2020 Randeep Dhaliwal. All rights reserved.
//

import SwiftUI

struct LandingView: View {
    var apiKey: String?

    init() {
        apiKey = KeychainStore.getValue(key: "gb_api_key")
    }

    var body: some View {
        Group {
            if apiKey != nil {
                ContentView()
            } else {
                LoginView()
            }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
