//
//  LoginView.swift
//  giantbomb
//
//  Created by Randeep Dhaliwal on 7/7/20.
//  Copyright © 2020 Randeep Dhaliwal. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State var thing: String

    var body: some View {
        VStack {
            Text("Login Screen")
            TextField("Thing", text: $thing)

            Button(action: {
                KeychainStore.saveValue(key: Environment.gbApiKeyIdentifier, value: "hello_there")
            }, label: {
                Text("Click me to save API Key")
            })
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(thing: "")
    }
}
