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

    @State var StartTime = 00*00*00
    @State private var showingAlert = false
    @State private var showingAlert2 = false
    let dateFormatter = DateFormatter()
    @State  var startTime = "00:00:00"
    @State var finishTime = "00:00:00"
    
    var body: some View{
        
        let places = [
            Place(name: "Position 1", latitude: 31.21, longitude: 120.50)
        ]
        
        VStack{
            Map(coordinateRegion: $region, showsUserLocation: true,  annotationItems: places){ place in
                MapMarker(coordinate: place.coordinate)
            }.ignoresSafeArea()
            CircleImage()
                .offset(y: -70)
                .padding(.bottom, -100)
            Spacer()
            
            
            VStack(alignment: .leading){
                HStack{
                    VStack{
                        Text(scooter.name!).foregroundColor(.black).padding()
                        if(uuid.isEmpty){
                            Text("TIME: \(timeString(time: StartTime*0))")
                        }
                        else{
                            Text("TIME: \(timeString(time: StartTime))")
                                .onReceive(timer){ _ in
                                    StartTime += 1
                            }
                        }
                    }
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
                            startRent(uuid: scooter.uuid)
                            
                        }.padding()
                            .background(.blue)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .shadow(radius: 10)
                            .alert("Perfect, you just rented the scooter: " + uuid, isPresented: $showingAlert){
                                Button("OK", role: .cancel){}
                            }
                        Spacer()
                        Button(uuid.isEmpty ? "NOTHING RENTED" : "STOP RENT"){
                            
                            uuid = ""
                            showingAlert2 = true
                            stopRent(uuid: scooter.uuid)
                            
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
    
    func startRent(uuid: String!){
        APIService.startRent(withToken: APIAccess.token, uuid: uuid){
            result in
            print (result)
        }
    }
    
    func stopRent(uuid: String!){
        APIService.stopRent(withToken: APIAccess.token, uuid: uuid){
            result in
            print (result)
        }
    }
    
    
//    func startScooterRent(uuid:String!)
//    {
//        APIService.startRent(withToken: APIAccess.token, uuid: uuid){(result:Result<ServerRent, NetworkError>) in
//            let context = dataController.container.viewContext
//            let query = NSFetchRequest<ScooterDB>(entityName: "RentDB")
//            _ = try? context.fetch(query)
//            do {
//                dataController.Rent(uuid: uuid)
//            }
//
//        }
//    }
    
    
    func stopScooterRent(uuid: String!){
        let context = dataController.container.viewContext
        let query = NSFetchRequest<ScooterDB>(entityName: "RentDB")
        _ = try? context.fetch(query)
        APIService.stopRent(withToken: APIAccess.token, uuid: uuid){
            (result:Result<ServerRent, NetworkError>) in
        }
        
        
    }
    
    /*func updateStartDate(uuid:String!){
        let context = dataController.container.viewContext
        let query = NSFetchRequest<RentDB>(entityName: "RentDB")
        let resultado = try? context.fetch(query)
        dateFormatter.timeStyle = .medium
        if finishTime != "00:00:00"{
            finishTime = "00:00:00"
        }
        for rent in resultado ?? []{
            if rent.uuid == uuid{
                startTime =  rent.date_start ?? "00:00:00"
            }
        }
    }*/

    
}
