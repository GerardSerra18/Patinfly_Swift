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
                        ScooterRowView(name: scooter.name, uuid: scooter.state, distance: "10")
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
    
    var body: some View{
        VStack{
            VStack(alignment: .leading, spacing: 10){
                Text(name).bold().foregroundColor(.black).font(.body)
                HStack{
                    Text(uuid).font(.body)
                    HStack{
                        Text("Km:")
                        Text(distance)
                    }.frame(width: 290, alignment: .trailing)
                }
            }
        }
    }
}
