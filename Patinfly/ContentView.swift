//
//  ContentView.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 13/9/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var scooters:Scooters = Scooters(scooters: [])

    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(scooters.scooters){ scooter in
                        ScooterRowView(
                            name: scooter.name, uuid: scooter.state, distance: "10", battery_level: scooter.battery_level)
                    }
                }
            }.navigationTitle("Scooters")
        }.onAppear{
            if let url = Bundle.main.url(forResource: "scooters", withExtension: "json"){
                do{
                    let jsonData = try Data(contentsOf: url)
                    print(jsonData)
                    let decoder = JSONDecoder()
                    print(try decoder.decode(Scooters.self, from: jsonData))
                    scooters = try decoder.decode(Scooters.self, from: jsonData)
                }catch{
                    print(error)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}

struct ScooterRowView: View {
    
    let name: String
    let uuid: String
    let distance: String
    let battery_level: Float
    
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
                            
                            let formattedFloat = String(format: "%1.f", battery_level)
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
                            //Text("Km:")
                            Text(distance + "  m") //sale 10 porque lo pusimos como constante, en el JSON hay KM y todos estan a 0.0
                        }
                    }.frame(width: 290, alignment: .trailing)
                }
            }
        }
    }
}
