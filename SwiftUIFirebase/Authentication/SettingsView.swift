//
//  SettingsView.swift
//  SwiftUIFirebase
//
//  Created by Kirill Frolovskiy on 18.03.2023.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    
    func singOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignView: Bool
    var body: some View {
        List {
            Button("Sing out") {
                Task {
                    do {
                        try viewModel.singOut()
                        showSignView = true
                    } catch {
                        print(error)
                    }
                }
            }
        }
        .navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            
            SettingsView(showSignView: .constant(false))
        }
    }
}
