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
    //@State private var selection: String? = nil
    
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                Image("IniciApp")
                Spacer()
                VStack{
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
                
                    NavigationLink(destination: ConditionsView()){
                        Text("Check Conditions")
                    }
                    //Window to check the conditions using navigation view and navigation link
                }
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
struct ConditionsView : View {
        var body: some View {
            NavigationView {
                VStack {
                    Text("MIT License Copyright © 2015-2020 Mark Callow, Khronos Group Inc, and Contributors to the KTX project Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the Software), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.")

                }
                .navigationBarHidden(true)
                .padding()
            }
        }
    }
