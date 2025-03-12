//
//  SignIn.swift
//  MTBRide
//
//  Created by Adnann Muratovic on 11.03.25.
//

import SwiftUI

struct SignIn: View {
    var body: some View {
        VStack(spacing: 45) {
            
            Text("Sign In")
            
            TopView(
                title: "Sign In",
                details: "Wellcome To",
                error: "Error"
            )
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
        
}


struct TopView: View {
    
    var title: String
    var details: String
    var error: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


#Preview {
    SignIn()
}
