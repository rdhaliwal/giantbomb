//
//  SettingsView.swift
//  giantbomb
//
//  Created by Randeep Dhaliwal on 29/5/20.
//  Copyright © 2020 Randeep Dhaliwal. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @State var red: Double
    @State var green: Double
    @State var blue: Double

    let targetRed = Double.random(in: 0..<1)
    let targetGreen = Double.random(in: 0..<1)
    let targetBlue = Double.random(in: 0..<1)

    var body: some View {
        VStack {
            Text("Settings")
                .navigationBarTitle(Text("Settings"))
            HStack(alignment: .top) {
                Color(red: targetRed, green: targetGreen, blue: targetBlue)
                    .frame(height: 200.0)
                VStack {
                    Color(red: red, green: green, blue: blue)
                        .frame(height: 200.0)
                    Text(String(format: "%.2f %.2f %.2f", red*255, green*255, blue*255))
                }
            }
            ColorSlider(value: $red, label: "R")
            ColorSlider(value: $green, label: "G")
            ColorSlider(value: $blue, label: "B")

        }
        .padding(.all, 20.0)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(red: 0.5, green: 0.5, blue: 0.5)
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var label: String

    var body: some View {
        HStack(alignment: .center) {
            Text("\(label): ")
            Text("0")
            Slider(value: $value)
            Text("255")
        }.padding(.horizontal, 5.0)
    }
}
