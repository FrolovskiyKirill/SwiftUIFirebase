//
//  AuthenticationView.swift
//  SwiftUIFirebase
//
//  Created by Kirill Frolovskiy on 18.03.2023.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

struct GoogleSingInResultModel {
  let idToken: String
  let accessToken: String
}

final class AutheticationViewModel: ObservableObject {

  func singInGoogle() async throws {
    guard let topVC = await Utilites.shared.topViewController() else {
      throw URLError(.cannotFindHost)
    }
    let gidSingInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
    //    gidSingInResult.user

    guard let idToken = gidSingInResult.user.idToken?.tokenString else {
      throw URLError(.badServerResponse)
    }
    let accessToken = gidSingInResult.user.accessToken.tokenString

    let tokens = GoogleSingInResultModel(idToken: idToken, accessToken: accessToken)
    try await AuthenticationManager.shared.singInWithGoogle(tokens: tokens)

  }
}


struct AuthenticationView: View {

  @StateObject private var viewModel = AutheticationViewModel()
  @Binding var showSignInView: Bool

  var body: some View {

    VStack {

      NavigationLink {
        SignInEmailView(showSignView: $showSignInView)
      } label: {
        Text("Sing In with Email")
          .font(.headline)
          .foregroundColor(.white)
          .frame(height: 55)
          .frame(maxWidth: .infinity)
          .background(Color.blue)
          .cornerRadius(10)
      }

      GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal)) {
        Task {
          do {
            try await viewModel.singInGoogle()
            showSignInView = false
          } catch {
            print(error)
          }
        }
      }
      Spacer()
    }
    .padding()
    .navigationTitle("Sign In")
  }
}

struct AuthenticationView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {

      AuthenticationView(showSignInView: .constant(false))
    }
  }
}
