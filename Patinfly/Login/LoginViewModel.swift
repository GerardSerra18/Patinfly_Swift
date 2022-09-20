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
        APIService.shared.login(credentials: credentials){[unowned self](result:Result<Bool, APIService.APIError>) in
            showProgressView = false
            switch result{
                case .success:
                    completition(true)
                case .failure:
                    completition(false)
            }
        }
    }
}
//Final lab3 prueba de commit despues de cerrar
