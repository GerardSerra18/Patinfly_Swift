//
//  ContentView.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 13/9/22.
//

import SwiftUI

struct ScooterListView: View {
    
    //@State var scooters:Scooters = Scooters(scooters: []) //Lo hacia servir solo para cuando lo añadiamos directamente del json
    
    @StateObject var dataController = DataController()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest (sortDescriptors:[]) var scooters_data: FetchedResults<ScooterDB>

    var body: some View {
        
        return NavigationView{
            VStack{
                List(scooters_data){ scooter in
                    NavigationLink{
                        ScooterDetailView(selectedScooter: Scooter(id: scooter.id!, uuid: scooter.uuid!, name: scooter.name!, longitude: scooter.longitude, latitude: scooter.latitude, battery_level: scooter.battery_level, km_use: scooter.km_use, date_last_maintenance: scooter.date_last_maintenance!, state: scooter.state!, on_rent: scooter.on_rent)).environment(\.managedObjectContext, dataController.container.viewContext)
                    }label: {
                        ScooterRowView(name: scooter.name!, uuid: scooter.uuid!, distance: "10", battery_level: scooter.battery_level).environment(\.managedObjectContext, dataController.container.viewContext)
                    }
                }
            }
        }
        
        

//        return NavigationView{
//            VStack{
//                List{
//                    ForEach(scooters.scooters){ scooter in
//                        NavigationLink(destination: ScooterDetailView(selectedScooter: scooter)){
//                            ScooterRowView(
//                                name: scooter.name, uuid: scooter.state, distance: "10", battery_level: scooter.battery_level)
//                        }
//                    }
//                }
//            }.navigationTitle("Scooters")
//
//
//        }.onAppear{
//            if let url = Bundle.main.url(forResource: "scooters", withExtension: "json"){
//                do{
//                    let jsonData = try Data(contentsOf: url)
//                    print(jsonData)
//                    let decoder = JSONDecoder()
//                    print(try decoder.decode(Scooters.self, from: jsonData))
//                    scooters = try decoder.decode(Scooters.self, from: jsonData)
//                }catch{
//                    print(error)
//                }
//            }
//        }
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
    @StateObject var dataController = DataController()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest (sortDescriptors:[]) var scooters_data: FetchedResults<ScooterDB>
    
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
                    }.frame(width: 290, alignment: .trailing).environment(\.managedObjectContext, dataController.container.viewContext)
                }
            }
        }
    }
}
