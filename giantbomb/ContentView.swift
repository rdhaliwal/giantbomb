//
//  ContentView.swift
//  giantbomb
//
//  Created by Randeep Dhaliwal on 17/5/20.
//  Copyright © 2020 Randeep Dhaliwal. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text(Environment.gbApiKey) 
            Text(Environment.gbApiUrl.absoluteString)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
