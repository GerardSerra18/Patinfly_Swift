//
//  ScooterDetailView.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 19/10/22.
//


import SwiftUI
import MapKit

struct ScooterDetailView: View {
    
    var selectedScooter: Scooter
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.1322888, longitude: 1.2452031), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest (sortDescriptors:[]) var scooters_data: FetchedResults<ScooterDB>
    
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
                        Text(selectedScooter.name).foregroundColor(.black).padding()
                        Spacer()
                        if (selectedScooter.battery_level == 100 ){
                            Image(systemName: "battery.100").font(.system(size: 25.0)).foregroundColor(.green)
                        }
                        else if (selectedScooter.battery_level < 100 && selectedScooter.battery_level > 50){
                            Image(systemName: "battery.75").font(.system(size: 25.0)).foregroundColor(.green)
                        }
                        else if (selectedScooter.battery_level == 50){
                            Image(systemName: "battery.50").font(.system(size: 25.0)).foregroundColor(.orange)
                        }
                        else{
                            Image(systemName: "battery.25").font(.system(size: 25.0)).foregroundColor(.red)
                        }
                        let formattedFloat = String(format: "%.1f", selectedScooter.battery_level)
                        Text("\(formattedFloat)")
                    }.padding()
                    VStack{
                        NavigationLink(destination: ActiveRentView(selectedScooter: selectedScooter)){
                            HStack{
                                Image(systemName: "figure.skiing.crosscountry").foregroundColor(.white)
                                Button("RENT"){
                                    let scooter_data: ScooterDB = ScooterDB(context: moc)
                                    scooter_data.uuid = selectedScooter.uuid
                                    scooter_data.name = selectedScooter.name
                                    scooter_data.longitude = selectedScooter.longitude
                                    scooter_data.latitude = selectedScooter.latitude
                                    scooter_data.km_use = selectedScooter.km_use
                                    scooter_data.date_last_maintenance = selectedScooter.date_last_maintenance
                                    scooter_data.battery_level = selectedScooter.battery_level
                                    scooter_data.state = selectedScooter.state
                                    scooter_data.on_rent = selectedScooter.on_rent
                                    scooter_data.id = selectedScooter.id
                                    try? moc.save()
                                }
                                
                            }.padding(20)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        Spacer()
                    }.padding(.horizontal,120)
                        .padding(.vertical,80)
                        .padding(.leading)
                }
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
    
    
