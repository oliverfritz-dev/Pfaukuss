//
//  OTPView.swift
//  Pfaukuss
//
//  Created by Privat on 20.03.26.
//

import SwiftUI

struct OTPView: View {
    @ObservedObject var viewModel: AuthViewModel
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("Check your email")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("We sent a 6-digit code to\n\(viewModel.email)")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)

            TextField("000000", text: $viewModel.otpCode)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .font(.title)
                .multilineTextAlignment(.center)
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
                    await viewModel.verifyOTP(appState: appState)
                }
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                } else {
                    Text("Verify")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.primary)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal)
            .disabled(viewModel.otpCode.count != 6 || viewModel.isLoading)

            Spacer()
        }
        .navigationBarBackButtonHidden(viewModel.isLoading)
    }
}
