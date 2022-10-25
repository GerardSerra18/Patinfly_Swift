//
//  MapView.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 18/10/22.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude:41.1322888, longitude: 1.2452031), //URV location
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    var body: some View{
        Map(coordinateRegion: $region)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View{
        MapView()
            .ignoresSafeArea(edges: .top)
    }
}
