//
//  LoginView.swift
//  Pfaukuss
//
//  Created by Privat on 20.03.26.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Text("Welcome")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Enter your email to get started")
                .foregroundColor(.secondary)
            
            TextField("Email", text: $viewModel.email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button {
                Task {
                    await viewModel.sendOTP()
                }
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                } else {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.primary)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal)
            .disabled(viewModel.email.isEmpty || viewModel.isLoading)
            
            Spacer()
        }
        .navigationDestination(isPresented: $viewModel.otpSent) {
            OTPView(viewModel: viewModel)
                .environmentObject(appState)
        }
    }
}
