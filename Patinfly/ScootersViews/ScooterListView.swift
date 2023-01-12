//
//  ContentView.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 13/9/22.
//

import SwiftUI

struct ScooterListView: View {
    
    //@State var scooters: Scooters = Scooters(scooters: []) //solo para cuando lo añadiamos directamente del json
    
    @StateObject var dataController = DataController()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest (sortDescriptors:[]) var scooters: FetchedResults<ScooterDB>

    var body: some View {
        
        return NavigationView{
            VStack{
                List(scooters){ scooter in
                    if(scooter.state == "ACTIVE"){
                        NavigationLink(destination: ScooterDetailView(scooter: scooter)){
                            ScooterRowView(
                                name: scooter.name!, uuid: scooter.state!, distance: "10", battery_level: scooter.battery_level)
                        }
                    }else{
                        NavigationLink(destination: ScooterDetailView(scooter: scooter)){
                            ScooterRowView(
                                name: scooter.name!, uuid: scooter.state!, distance: "10", battery_level: scooter.battery_level)
                        }
                    }
                        
                }
                .navigationTitle("Scooters")
            }
        }
    }
}


struct ScooterListView_Previews: PreviewProvider {
    static var previews: some View {
            ScooterListView()
    }
}

struct ScooterRowView: View {
    
    let name: String
    let uuid: String
    let distance: String
    let battery_level: Float
    @Environment(\.managedObjectContext) var moc
    @StateObject var dataController = DataController()

    
    var body: some View{
        VStack{
            VStack(alignment: .leading, spacing: 10){
                Text(name).bold().foregroundColor(.black).font(.body)
                HStack{
                    if uuid == "ACTIVE"{
                        Image(systemName: "scooter").font(.system(size: 25.0)).foregroundColor(.green)
                    }
                    else{
                        Image(systemName: "scooter").font(.system(size: 25.0)).foregroundColor(.red)
                    }
                    HStack{
                        VStack{
                            
                            //let formattedFloat = String(format: "%1.f", battery_level)
                            if (battery_level == 100 ){
                                Image(systemName: "battery.100").font(.system(size: 25.0)).foregroundColor(.green)
                                //Text("Battery Level: \(formattedFloat)")
                            }
                            else if (battery_level < 100 && battery_level > 50){
                                Image(systemName: "battery.75").font(.system(size: 25.0)).foregroundColor(.green)
                                //Text("Battery Level: \(formattedFloat)")
                            }
                            else if (battery_level == 50){
                                Image(systemName: "battery.50").font(.system(size: 25.0)).foregroundColor(.orange)
                                //Text("Battery Level: \(formattedFloat)")
                            }
                            else{
                                Image(systemName: "battery.25").font(.system(size: 25.0)).foregroundColor(.red)
                                //Text("Battery Level: \(formattedFloat)").foregroundColor(.green)
                            }
                            Spacer()
                            Text(distance + "  m")
                            //sale 10 porque lo pusimos como constante, en el JSON hay KM y todos estan a 0.0
                            //Tendremos que realizar otro formattedFloat para poder poner por pantalla la vista del Float
                            //Como en el caso de la bateria por si lo queremos imprimir
                        }
                    }.frame(width: 290, alignment: .trailing)
                }
            }
        }
    }
}
