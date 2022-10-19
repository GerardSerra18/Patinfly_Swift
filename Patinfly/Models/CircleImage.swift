//
//  CircleImage.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 19/10/22.
//

import Foundation
import SwiftUI

struct CircleImage: View{
    var body: some View{
        Image("IniciApp")
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.blue, lineWidth: 3)
            }
            .shadow(radius: 40)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View{
        CircleImage()
    }
}
