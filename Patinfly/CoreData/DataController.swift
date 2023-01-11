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
//    var uuid: String = UserDefaults.standard.string(forKey: "uuid")!
    @Environment(\.managedObjectContext) var moc
    
    init(){
        container.loadPersistentStores{
            description, error in
            if let error = error{
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    /*func searchScooter()-> ScooterDB?{
        print(uuid)
        @FetchRequest (sortDescriptors:[]) var scooters: FetchedResults<ScooterDB>
        
        print(moc)
        if (container == nil){
            
            return nil
            
        }
        let context = container.viewContext
        let request = NSFetchRequest<ScooterDB>(entityName: "ScooterDB")
        let stringValue = uuid as CVarArg
        
//        request.predicate = NSPredicate(format: "uuid == %@", stringValue)
        
            let resultado = try? context.fetch(request)
            print(resultado)
            return resultado!.first
    }*/
    
    func save(scooter: Scooter){
        let ScooterToSave: ScooterDB = ScooterDB(context: container.viewContext)
        
        ScooterToSave.id = scooter.id
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
    /*
    func saveRent(uuid: String){
        let rentData: RentDB = RentDB(context: container.viewContext)
        rentData.uuid=uuid
        try? container.viewContext.save()
    }*/
    
}
