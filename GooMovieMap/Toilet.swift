//
//  Toilet.swift
//  GooMovieMap
//
//  Created by Hawk on 31/03/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

extension Toilet {
    class func fromJSON(json: JSON) -> Toilet? {
        
        var coordinate : CLLocationCoordinate2D?
        if let latValue = json["Lat"].double, let lonValue = json["Lon"].double {
            coordinate = CLLocationCoordinate2D(latitude: latValue, longitude: lonValue)
        }
        
        var address : String?
        if let addressValue = json["Cells"]["Address"].string {
            address = addressValue
        }
        
        var workingHours : String?
        if let workingHoursValue = json["Cells"]["WorkingHours"].string {
            workingHours = workingHoursValue
        }
        
        if let address = address, let workingHours = workingHours, let coordinate = coordinate {
            return Toilet(address: address, workingHours: workingHours, coordinate: coordinate)
        } else {
            return nil
        }
    }
}

class Toilet: NSObject {
    var title: String? {
        return address
    }
    var subtitle: String? {
        return workingHours
    }
    
    
    let address: String
    let workingHours : String
    let coordinate: CLLocationCoordinate2D
    
    init(address: String, workingHours : String, coordinate: CLLocationCoordinate2D) {
        self.address = address
        self.workingHours = workingHours
        self.coordinate = coordinate
        
        super.init()
    }
}