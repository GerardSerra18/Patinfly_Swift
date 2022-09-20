//
//  LoginViewModel.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 20/9/22.
//

import Foundation

class LoginViewModel: ObservableObject{
    
    @Published var credentials = Credentials()
    @Published var showProgressView = false
    
    var loginDisable: Bool{
        
        credentials.email.isEmpty || credentials.password.isEmpty
    }
    
    func login(completition: @escaping(Bool) -> Void){
        showProgressView = true
    }
}
