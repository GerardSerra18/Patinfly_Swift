//
//  ScooterDB.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 29/11/22.
//

import Foundation
import CoreData
import SwiftUI



class DataController: ObservableObject{
    let container = NSPersistentContainer(name:"ScooterDatabase")
    @Environment(\.managedObjectContext) var moc
    
    init(){
        container.loadPersistentStores{
            description, error in
            if let error = error{
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func save(scooter: Scooter){
        let ScooterToSave: ScooterDB = ScooterDB(context: container.viewContext)
        
//        ScooterToSave.id = scooter.id
        ScooterToSave.name = scooter.name
        ScooterToSave.uuid = scooter.uuid
        ScooterToSave.longitude = scooter.longitude
        ScooterToSave.latitude = scooter.latitude
        ScooterToSave.battery_level = scooter.battery_level
        ScooterToSave.date_last_maintenance = scooter.date_last_maintenance
        ScooterToSave.state = scooter.state
        ScooterToSave.on_rent = scooter.on_rent
        try? container.viewContext.save()
    }
    
    //Function to save the rent of the scooter
    func Rent(uuid: String){
        let scooterRented: RentDB = RentDB(context: container.viewContext)
        scooterRented.uuid=uuid
        try? container.viewContext.save()
    }
    
}
