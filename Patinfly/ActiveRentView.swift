//
//  ActiveRentView.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 19/10/22.
//

import Foundation
import SwiftUI
struct ActiveRentView: View {
    
    var selectedScooter: Scooter
    @State var StartTime = 00*00*00
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View{
        NavigationView{
            VStack{
                MapView()
                    .ignoresSafeArea()
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
                        NavigationLink(destination: ScooterDetailView(selectedScooter: selectedScooter)){
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
    }
    
    func timeString(time: Int) -> String {
        let hours   = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}

