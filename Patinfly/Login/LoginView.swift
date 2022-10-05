//
//  LoginView.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 20/9/22.
//

import SwiftUI

struct LoginView: View {
    
    //@State var labelText: String = "No selected"
    @StateObject private var loginViewModel = LoginViewModel()
    @EnvironmentObject var authentication: Authentication
    @State private var ToogleActivado = true
    @State private var selection: String? = nil
    
    var body: some View {
        VStack {
            HStack{
                Image("IniciApp")
                Divider()

            }.padding()
            Text("Patinfly").font(.largeTitle).foregroundColor(.blue)
            TextField("EMAIL", text: $loginViewModel.credentials.email).keyboardType(.emailAddress)
            
            SecureField("PASSWORD", text: $loginViewModel.credentials.password)
            if loginViewModel.showProgressView{
                ProgressView()
            }
            Toggle("Conditions", isOn: $ToogleActivado).padding()
            Button("Login"){
                loginViewModel.login{
                    success in
                    authentication.updateValidation(success: success)
                }
            }
            .disabled(loginViewModel.loginDisable).padding(20)
            .disabled(!ToogleActivado)
            
            Button("Check Conditions"){
                //Realizar el enlaze con un navigation link or navigation view
            }
            
            
        }.padding(.horizontal,60)
            .padding(.vertical,20)
            .autocapitalization(.none)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .disabled(loginViewModel.showProgressView)
            .alert(item: $loginViewModel.error){
            error in Alert(title: Text("Error validació"), message: Text(error.localizedDescription))
        }
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
