//
//  SplashScreen.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 4/10/22.
//

import SwiftUI

struct SplashScreen: View{
    
    @StateObject var authentication = Authentication()
    //    @Environment(\.managedObjectContext) var moc
    //    @StateObject var dataController = DataController()
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View{
        if self.isActive{
            if authentication.isValidated{
                ScooterListView()
            }
            else{
                LoginView()
                //ScooterListView()//solo para pruebas !!!
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
                    //Codigo utilizado en P2 para guardar los datos en la base de datos
                    /*if let url = Bundle.main.url(forResource: "scooters", withExtension: "json"){
                     do{
                     // Modificacion para en esta práctica guardar los objetos del json en la base de datos
                     let dataController = DataController()
                     let jsonData = try Data(contentsOf: url)
                     print(jsonData)
                     let decoder = JSONDecoder()
                     print(try decoder.decode(Scooters.self, from: jsonData))
                     let scooters: Scooters = try decoder.decode(Scooters.self, from: jsonData)
                     for scooter in scooters.scooters{
                     dataController.save(scooter: scooter)
                     }
                     }*/
                    
                    //Codigo P3, utilizando servidor del patinfl
                    //Comprobacion del servidor, lo imprimo porque quiero ver que no existe ningun tipo de problema
                    APIService.checkServerStatusWithCompletion(){
                        result in
                        print (result)
                    }
                    APIService.scooterListWithCompletion(withToken: APIAccess.token){
                        result in
                        print (result)
                    }
                    //Si la comprobacion del servidor ha ido bien sin ningun error guardar todos los patinetes en la db
                    APIService.checkServerStatusWithCompletion(){(result: Result<ServerStatus, NetworkError>) in
                        if ((try? result.get().status) != nil){
                            APIService.scooterList(withToken: APIAccess.token)
                            APIService.scooterListWithCompletion(withToken: APIAccess.token){(result: Result<Scooters, NetworkError>) in
                                do{
                                    let dataController = DataController()
                                    for scooter in try result.get().scooters{
                                        dataController.save(scooter: scooter)
                                    }
//                                    print("TOT GUARDAT CORRECTAMENT")
                                }catch let parseError{
                                    print("JSON Error \(parseError.localizedDescription)")
                                }
                            }
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
