//
//  PatinflyApp.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 13/9/22.
//

import SwiftUI

@main
struct PatinflyApp: App {
    
    @FetchRequest (sortDescriptors:[]) var scooter_data: FetchedResults<ScooterDB>
    @Environment(\.managedObjectContext) var moc
    @StateObject var authentication = Authentication()
    @StateObject var dataController = DataController()
//    var uuid = UserDefaults.standard.string(forKey: "uuid")

        
    var body: some Scene {
        WindowGroup{
            
            
            if authentication.isValidated{
            
                ScooterListView().environmentObject(authentication).environment(\.managedObjectContext, dataController.container.viewContext)
            }
            else{
                
                SplashScreen().environmentObject(authentication).environment(\.managedObjectContext, dataController.container.viewContext)
                        
            }
            
        }
    }
}
