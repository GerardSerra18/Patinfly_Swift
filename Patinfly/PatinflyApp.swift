//
//  PatinflyApp.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 13/9/22.
//

import SwiftUI

@main
struct PatinflyApp: App {
    
//    @FetchRequest (sortDescriptors:[]) var scooters_data: FetchedResults<ScooterDB>
    @StateObject var authentication = Authentication()
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        
        WindowGroup {
            
            if authentication.isValidated{
                ScooterListView().environmentObject(authentication).environment(\.managedObjectContext, dataController.container.viewContext)
            }
            else{
                SplashScreen().environmentObject(authentication).environment(\.managedObjectContext, dataController.container.viewContext)
                
            }
           
        }
    }
}
