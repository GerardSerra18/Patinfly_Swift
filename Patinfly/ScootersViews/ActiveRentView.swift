//
//  ActiveRentView.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 19/10/22.
//

import Foundation
import SwiftUI
import _MapKit_SwiftUI
struct ActiveRentView: View {
    
    var scooter: ScooterDB
    @StateObject var dataController = DataController()
    @Environment(\.managedObjectContext) var moc

    
    @State var StartTime = 00*00*00
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.1322888, longitude: 1.2452031), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    struct Place: Identifiable {
        let id = UUID()
        let name: String
        let latitude: Double
        let longitude: Double
        var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }

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
                    
                    VStack{
                        NavigationLink(destination: ScooterListView().environment(\.managedObjectContext, dataController.container.viewContext).navigationBarBackButtonHidden(true)){
                            HStack{
                                Image(systemName: "stop.circle.fill").foregroundColor(.white)
                                Text("STOP").font(.headline).foregroundColor(.white)
                                
                                
                            }.padding(20)
                                .background(Color.blue)
                                .cornerRadius(10)
                                
                        }
                        
                    }.padding(.horizontal,120)
                        .padding(.vertical,80)
                        .padding(.leading)
                    Spacer()
                    VStack{
                        
                        VStack(alignment: .leading){
                            Text("TIME: \(timeString(time: StartTime))")
                                .onReceive(timer){ _ in
                                    
                                    StartTime += 1
                                }
                            Text("METERS: 10m")
                        }.padding()
                        
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
}

