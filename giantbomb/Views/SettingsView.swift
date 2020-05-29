//
//  SettingsView.swift
//  giantbomb
//
//  Created by Randeep Dhaliwal on 29/5/20.
//  Copyright © 2020 Randeep Dhaliwal. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Text("Body")
            .navigationBarTitle(Text("Settings"))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
