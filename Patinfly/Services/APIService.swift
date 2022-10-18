//
//  APIService.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 27/9/22.
//

import Foundation

class APIService{
    
    static let shared = APIService()
    
    enum APIError: Error {
        
        case error
    }
    
    func validUser(credentials: Credentials) -> Bool {
        return ((credentials.email == "gerard.serra@estudiants.urv.cat") && (credentials.password == "12345"))
    }
    
    func login(credentials: Credentials, completition: @escaping (Result<Bool, Authentication.AuthenticationError>)-> Void){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            if self.validUser(credentials: credentials){
                completition(.success(true))
            }
            else{
                completition(.failure(.invalidCredentials))
            }
        }
    }
}
