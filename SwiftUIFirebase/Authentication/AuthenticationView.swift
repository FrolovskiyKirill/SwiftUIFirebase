//
//  AuthenticationView.swift
//  SwiftUIFirebase
//
//  Created by Kirill Frolovskiy on 18.03.2023.
//

import SwiftUI

struct AuthenticationView: View {
    
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
