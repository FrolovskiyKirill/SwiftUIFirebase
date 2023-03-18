//
//  SignInEmailView.swift
//  SwiftUIFirebase
//
//  Created by Kirill Frolovskiy on 18.03.2023.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func singIn() {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnedUserData)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
}

struct SignInEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    
    var body: some View {
        VStack {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                viewModel.singIn()
            } label: {
                Text("Sing In with Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign in With Email")
    }
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInEmailView()
        }
    }
}
