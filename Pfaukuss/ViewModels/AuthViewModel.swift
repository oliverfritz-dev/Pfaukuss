//
//  AuthViewModel.swift
//  Pfaukuss
//
//  Created by Privat on 20.03.26.
//

import SwiftUI
import Supabase
import Combine

@MainActor
class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var otpCode: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var otpSent: Bool = false

    func sendOTP() async {
        isLoading = true
        errorMessage = nil
        do {
            try await supabase.auth.signInWithOTP(
                email: email,
                shouldCreateUser: true
            )
            otpSent = true
        } catch {
            errorMessage = "Failed to send code. Please try again."
        }
        isLoading = false
    }

    func verifyOTP(appState: AppState) async {
        isLoading = true
        errorMessage = nil
        do {
            try await supabase.auth.verifyOTP(
                email: email,
                token: otpCode,
                type: .email
            )
            appState.isLoggedIn = true
        } catch {
            errorMessage = "Invalid code. Please try again."
        }
        isLoading = false
    }
}
