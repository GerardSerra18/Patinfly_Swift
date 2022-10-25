//
//  ScooterDetailView.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 19/10/22.
//

import Foundation
import SwiftUI
struct ScooterDetailView: View {
    
    var selectedScooter: Scooter

    var body: some View{
        
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
                            //Text("Battery Level: \(formattedFloat)")
                        }
                        else if (selectedScooter.battery_level < 100 && selectedScooter.battery_level > 50){
                            Image(systemName: "battery.75").font(.system(size: 25.0)).foregroundColor(.green)
                            //Text("Battery Level: \(formattedFloat)")
                        }
                        else if (selectedScooter.battery_level == 50){
                            Image(systemName: "battery.50").font(.system(size: 25.0)).foregroundColor(.orange)
                            //Text("Battery Level: \(formattedFloat)")
                        }
                        else{
                            Image(systemName: "battery.25").font(.system(size: 25.0)).foregroundColor(.red)
                            //Text("Battery Level: \(formattedFloat)").foregroundColor(.green)
                        }
                        let formattedFloat = String(format: "%.1f", selectedScooter.battery_level)
                        Text("\(formattedFloat)")
                    }.padding()
                    VStack{
                        NavigationLink(destination: ActiveRentView(selectedScooter: selectedScooter)){
                                HStack{
                                    Image(systemName: "figure.skiing.crosscountry").foregroundColor(.white)
                                    Text("RENT").font(.headline).foregroundColor(.white)
                                
                            }.padding(20)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        Spacer()
                    }.padding(.horizontal,120)
                        .padding(.vertical,80)
                        .padding(.leading)
                }
            }
        
    }
}

