//
//  AppTitle.swift
//  Insta
//
//  Created by YuanChingChen on 2023/7/22.
//

import SwiftUI

struct AppTitle: View {
    var body: some View {
        Text("Petstagram")
            .font(.custom("CoolStoryregular", size: 48, relativeTo: .headline))
    }
}

struct AppTitle_Previews: PreviewProvider {
    static var previews: some View {
        AppTitle()
    }
}
