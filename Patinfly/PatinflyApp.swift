//
//  PatinflyApp.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 13/9/22.
//

import SwiftUI

@main
struct PatinflyApp: App {
    
    @StateObject var authentication = Authentication()
    
    var body: some Scene {
        
        WindowGroup {
            
            if authentication.isValidated{
                ContentView().environmentObject(authentication)
            }
            else{
                LoginView().environmentObject(authentication)
            }
           
        }
    }
}
