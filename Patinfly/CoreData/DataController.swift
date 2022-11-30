//
//  ScooterDB.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 29/11/22.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    let container = NSPersistentContainer(name:"ScooterDB")
    
    init(){
        container.loadPersistentStores{
            description, error in
            if let error = error{
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func save(name: String, uuid: String, latitude: Float, longitude: Float, km_use: Float, battery_level: Float, date_last_maintenance: String, state: String, on_rent: Bool){
        // NSManagedObjectContext
        let scooter = ScooterDB(context: container.viewContext)
        scooter.name = name
        scooter.uuid = uuid
        scooter.latitude = latitude
        scooter.longitude = longitude
        scooter.km_use = km_use
        scooter.battery_level = battery_level
        scooter.date_last_maintenance = date_last_maintenance
        scooter.state = state
        scooter.on_rent = on_rent
        
        try? container.viewContext.save()
    }
    
}
