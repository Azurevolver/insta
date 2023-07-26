//
//  ContentView.swift
//  Insta
//
//  Created by YuanChingChen on 2023/7/15.
//

import SwiftUI
import Combine

struct ContentView: View {
  @State private var showingLogin = true
  let signInPublisher = NotificationCenter.default
    .publisher(for: .signInNotification)
    .receive(on: RunLoop.main)
  let signOutPublisher = NotificationCenter.default
    .publisher(for: .signOutNofication)
    .receive(on: RunLoop.main)
  
  var body: some View {
    Text("Hello, world!").padding()
      .fullScreenCover(isPresented: $showingLogin) {
        LoginSignupView()
      }
      .onReceive(signInPublisher) { _ in
        showingLogin = false
      }
      .onReceive(signOutPublisher) { _ in
        showingLogin = true
      }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
