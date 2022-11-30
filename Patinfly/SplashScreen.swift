//
//  SplashScreen.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 4/10/22.
//

import SwiftUI

struct SplashScreen: View{
    
    @StateObject var authentication = Authentication()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest (sortDescriptors:[]) var scooters_data: FetchedResults<ScooterDB>
    @StateObject var dataController = DataController()
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View{
        if self.isActive{
            if authentication.isValidated{
                ScooterListView().environment(\.managedObjectContext, dataController.container.viewContext)
            }
            else{
                //LoginView().environment(\.managedObjectContext, dataController.container.viewContext)
                ScooterListView().environment(\.managedObjectContext, dataController.container.viewContext) //solo para pruebas !!!
            }
        }
        else{
            VStack{
                VStack{
                    Image(uiImage: UIImage(named: "Logo") ??
                          UIImage()).scaleEffect(0.8)
                    Text("Patinfly").font(.title)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{withAnimation(.easeIn(duration: 1.2)){
                    self.size = 1.0
                    self.opacity = 1.0
                }
                }
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){//Segundos que esta activado el splash
                    withAnimation{
                        self.isActive = true
                    }
                    if let url = Bundle.main.url(forResource: "scooters", withExtension: "json"){
                        do{
                            let dataController = DataController()
                            let jsonData = try Data(contentsOf: url)
                            print(jsonData)
                            let decoder = JSONDecoder()
                            print(try decoder.decode(Scooters.self, from: jsonData))
                            let scooters: Scooters = try decoder.decode(Scooters.self, from: jsonData)
                            for scooter in scooters.scooters{
                                dataController.save(name: scooter.name, uuid: scooter.uuid, latitude: scooter.latitude, longitude: scooter.longitude, km_use: scooter.km_use, battery_level: scooter.battery_level, date_last_maintenance: scooter.date_last_maintenance, state: scooter.state, on_rent: scooter.on_rent)
                            }
                        }catch{
                            print(error)
                        }
                    }
                }
            }
        }
    }
    
    struct SplashScreen_Previews:
        PreviewProvider{
        static var previews: some View{
            SplashScreen().previewInterfaceOrientation(.portrait)
            SplashScreen().previewInterfaceOrientation(.landscapeLeft)
        }
    }
    
    
    
}
