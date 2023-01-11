//
//  ServerRent.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 11/1/23.
//

import Foundation

struct RentStart: Codable{
    let uuid: String
    let date_start: String
    let date_stop: String?
}


struct ServerRent: Codable {
    let code:Int
    let msg: String
    let rent: RentStart
    let timestamp: String
    let version: Int?
}
 
