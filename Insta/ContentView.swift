//
//  ContentView.swift
//  Insta
//
//  Created by YuanChingChen on 2023/7/15.
//

import SwiftUI
import Combine

struct ContentView: View {
    var publisher: AnyCancellable = {
      let client = APIClient()
      let request = PostRequest()
      return client.publisherForRequest(request)
        .sink(receiveCompletion: { (result) in
          print(result)
        }, receiveValue: { (newPosts) in
          print(newPosts)
        })
    }()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
