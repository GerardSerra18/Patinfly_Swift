//
//  AccessConstants.swift
//  Patinfly
//
//  Created by Gerard Serra Rodríguez on 11/1/23.
//

import Foundation

struct APIAccess {
    
    static let scheme = "https"
    static let host = "patinfly.com"
    static let token: String = "ORJfKi5qMsPSxpl9tmALZeEoc0jdFYGkNTa4UDWC" //Token proporcionat per correu del Tomas
    static let urlServer: String = "https://patinfly.com/"
    static let pathStatus: String = "/endpoints/status/"
    static let pathScooter: String = "/endpoints/scooter/"
    static let pathScooterStart: String = "/endpoints/rent/start"
    static let pathScooterStop: String = "/endpoints/rent/stop"
    
    static func scooters() -> URLComponents{
        var urlServerScooters: URLComponents = APIAccess.baseURL()
        urlServerScooters.path = APIAccess.pathScooter
        return urlServerScooters
    }
    
    static func serverStatus() -> URLComponents{
        var urlServerStatus: URLComponents = APIAccess.baseURL()
        urlServerStatus.path = APIAccess.pathStatus
        return urlServerStatus
    }
    
    static func baseURL() -> URLComponents{
        var baseServerURL: URLComponents = URLComponents()
        baseServerURL.scheme = APIAccess.scheme
        baseServerURL.host = APIAccess.host
        return baseServerURL
    }
   
}
