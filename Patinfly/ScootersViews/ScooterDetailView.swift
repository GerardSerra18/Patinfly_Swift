//
//  ScooterDetailView.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 19/10/22.
//


import SwiftUI
import MapKit
import CoreData

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct ScooterDetailView: View {
    
    var scooter: ScooterDB
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.1322888, longitude: 1.2452031), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @Environment(\.managedObjectContext) var moc
    @StateObject var dataController = DataController()

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @AppStorage("uuid") var uuid: String = ""

//    @State private var start = false
//    @State private var stop = true
    @State var StartTime = 00*00*00
    @State private var showingAlert = false
    @State private var showingAlert2 = false
    
    var body: some View{
        
        let places = [
            Place(name: "Position 1", latitude: 31.21, longitude: 120.50)
        ]
        
        VStack{
            Map(coordinateRegion: $region, showsUserLocation: true,  annotationItems: places){ place in
                // MapPin(coordinate: place.coordinate)
                MapMarker(coordinate: place.coordinate)
            }.ignoresSafeArea()
            CircleImage()
                .offset(y: -70)
                .padding(.bottom, -100)
            Spacer()
            
            
            VStack(alignment: .leading){
                HStack{
                    Text(scooter.name!).foregroundColor(.black).padding()
                    Spacer()
                    if (scooter.battery_level == 100 ){
                        Image(systemName: "battery.100").font(.system(size: 25.0)).foregroundColor(.green)
                    }
                    else if (scooter.battery_level < 100 && scooter.battery_level > 50){
                        Image(systemName: "battery.75").font(.system(size: 25.0)).foregroundColor(.green)
                    }
                    else if (scooter.battery_level == 50){
                        Image(systemName: "battery.50").font(.system(size: 25.0)).foregroundColor(.orange)
                    }
                    else{
                        Image(systemName: "battery.25").font(.system(size: 25.0)).foregroundColor(.red)
                    }
                    let formattedFloat = String(format: "%.1f", scooter.battery_level)
                    Text("\(formattedFloat)")
                }.padding()
                    HStack{
                        
                        Button(uuid.isEmpty ? "START RENT" : "ON TRIP"){
                            
                            uuid = scooter.name!
                            showingAlert = true
                            
                        }.padding()
                            .background(.blue)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .shadow(radius: 10)
                            .alert("Perfect, you just rented the scooter: " + uuid, isPresented: $showingAlert){
                                Button("OK", role: .cancel){}
                            }.onAppear(){
//                                startRent(uuid: scooter.uuid)
                            }.onDisappear(){
                                print("FUNCIONA")
                            }
                        Spacer()
                        Button(uuid.isEmpty ? "NOTHING RENTED" : "STOP RENT"){
                            
                            uuid = ""
                            showingAlert2 = true
                            
                        }.padding()
                        .background(.red)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .shadow(radius: 10)
                            .alert("Perfect right now you just finished the rental of the scooter!", isPresented: $showingAlert2){
                                Button("OK", role: .cancel){}
                            }
                        
                    }.padding(.vertical,90)
                    .padding(.horizontal, 20)
                    .padding(.leading)
                    .shadow(radius: 10)
                    
                
            }.onAppear(){
                LocationManager.shared.getUserLocation{ location in
                    DispatchQueue.main.async{
                        region.center.latitude = location.coordinate.latitude
                        region.center.longitude = location.coordinate.longitude
                    }
                }
            }
        }
    }
    func timeString(time: Int) -> String {
        let hours   = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    //Func para poder alquilar y parar el alquiler de los patinetes, controlarlos a traves de la database
    
//    func startRent(uuid: String!){
//        let data = DataController()
//        data.saveRent(uuid: uuid)
//    }
    
    func stopRent(uuid: String!) {
        let container = NSPersistentContainer(name: "RentDB")
        let context = container.viewContext
        let query = NSFetchRequest<NSFetchRequestResult>(entityName: "RentDB")
        do{
            let result = try context.fetch(query)
            for data in result as! [NSManagedObject]{
                context.delete(data.value(forKey: "uuid") as! NSManagedObject)
            }
        }
        catch{
            print("error")
        }
    }
}

class ActiveRent: ObservableObject {
    @Published var isRented = false
}
