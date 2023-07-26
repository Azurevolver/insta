//
//  LoginSignUpView.swift
//  Insta
//
//  Created by YuanChingChen on 2023/7/17.
//

import SwiftUI
import Combine

enum AuthState {
    case signUp
    case signIn
}

struct LoginSignupView: View {
    @State var authState: AuthState = .signUp
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var validationError = false
    @State private var requestError = false
    @State private var requestErrorText: String = ""
    @State var networkOperation: AnyCancellable?
    
    var body: some View {
        VStack(spacing: 55) {
            AppTitle()
            
            let columns: [GridItem] = [
                GridItem(.flexible(), spacing: 8, alignment: .leading),
                GridItem(.flexible())
            ]
            
            LazyVGrid(columns: columns) {
                // username
                Text("Username")
                TextField("Username", text: $username)
                    .textContentType(.username)
                    .autocapitalization(.none)
                
                // email
                if authState == .signUp {
                    Text("Email")
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                }
                
                // password
                Text("password")
                SecureField("password", text: $password)
                    .textContentType(.password)
                
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .alert(isPresented: $validationError) {
              if authState == .signUp {
                return Alert(title: Text("Please complete the username, email, and password fields"))
              } else {
                return Alert(title: Text("Please complete the username and password fields"))
              }
            }
            
            // button stack
            // button colors are in Assets.xcassets
            VStack(spacing: 8) {
              Button(action: {
                doAuth()
              }) {
                HStack {
                  Spacer()
                  Text(authState == .signUp ? "Sign Up" : "Sign In")
                    .foregroundColor(.white)
                  Spacer()
                }
              }
              .padding([.top, .bottom], 10)
              .background(Color.accentGreen.opacity(0.2))
              .clipShape(Capsule())
              .alert(isPresented: $requestError) {
                Alert(title: Text(requestErrorText))
              }

              Button(action: {
                withAnimation { toggleState() }
              }) {
                HStack {
                  Spacer()
                  Text(authState == .signUp ? "Sign In" : "Sign Up")
                  Spacer()
                }
              }
              .padding([.top, .bottom], 10)
              .overlay(Capsule().stroke(Color.accentGreen, lineWidth: 2))
            }
            .padding(.horizontal, 50)
            .accentColor(.accentGreen)
        }
        .padding(.horizontal)
        
    }
    
    private func toggleState() {
      authState = (authState == .signUp ? .signIn : .signUp)
    }
    
    private func doAuth() {
//      networkOperation?.cancel()
//      switch authState {
//      case .signIn:
//        doSignIn()
//      case .signUp:
//        doSignUp()
//      }
    }
}

struct LoginSignupView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSignupView()
    }
}
