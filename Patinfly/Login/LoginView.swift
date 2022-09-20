//
//  LoginView.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 20/9/22.
//

import SwiftUI

struct LoginView: View {
    @State var user: String = ""
    @State var password: String = ""
    @State var labelText: String = "NO SELECTED"
    var body: some View {
        VStack {
            Text("Patinfly").font(.largeTitle)
            TextField("USER", text: $user).keyboardType(.emailAddress).padding(.horizontal,60).padding(.vertical,20)
            
            SecureField("PASSWORD", text: $password).padding(.horizontal,60).padding(.vertical,20)
            
            Button("Sign In"){labelText = "SELECTED"}.padding(20)
            
        }
        
        TextField("", text: $labelText).padding(.horizontal,80)
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView().previewInterfaceOrientation(.portrait)
            LoginView().previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
