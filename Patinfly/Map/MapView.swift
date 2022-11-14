//
//  MapView.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 18/10/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude:41.1322888, longitude: 1.2452031), //URV location
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    var body: some View{
        VStack{
            Map(coordinateRegion: $region)
                .frame(width: 400, height: 300)
            Spacer()
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

struct MapView_Previews: PreviewProvider {
    static var previews: some View{
        MapView()
            .ignoresSafeArea(edges: .top)
    }
}


