//
//  RootView.swift
//  SwiftUIFirebase
//
//  Created by Kirill Frolovskiy on 18.03.2023.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignView = false
    
    var body: some View {
        
        ZStack {
            NavigationStack {
                SettingsView(showSignView: $showSignView)
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignView = authUser == nil
        }
        
        .fullScreenCover(isPresented: $showSignView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignView)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
