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

extension FunnyPlace {
    /*
    nam, lat, lon, txt, descr, img, t, Comment, url
    t - это тип объект
    */
    class func fromSwiftyJSONNetwork(json: JSON) -> FunnyPlace? {
        var title : String?
        if let name = json["nam"].string {
            title = name
        }
        
        var description : String?
        if let desc = json["descr"].string {
            description = desc
        }
        
        var text : String?
        if let txt = json["txt"].string {
            text = txt
        }
        
        var urlString : String?
        if let url = json["url"].string {
            urlString = url
        }
        
        
        var type : String?
        if let t = json["t"].string {
            type = t
        }
        /* Need Asynchronius download*/
        var image : String?
        if let img = json["img"].string {
            image = img
        }
        
        var coordinate : CLLocationCoordinate2D?
        if let latValue = json["lat"].string, lonValue = json["lon"].string {
            if let doubleLat = Double(latValue), doubleLong = Double(lonValue) {
                coordinate = CLLocationCoordinate2D(
                    latitude: doubleLat, longitude: doubleLong )
            }
        }
        
        var comment : String?
        if let comm = json["Comment"].string {
            comment = comm
        }
        
        if let title = title, description = description, comment = comment,
            url = urlString, image = image, type = type, coordinate = coordinate {
        return FunnyPlace(
            title: title,
            desc: description,
            comment: comment,
            url: url,
            type: type,
            image: image,
            coordinate: coordinate)
        } else {
            return nil
        }
    }
    
    
}

class FunnyPlace: NSObject {
    /*
    nam, lat, lon, txt, descr, img, t, Comment, url
    t - это тип объект
    */
    
    var title: String //name
    var desc: String
    
    var comment: String
    var url: String
    
    var type: String //sometype??
    
    var image: String
    
    //let address: String
    //let workingHours : String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, desc : String, comment: String, url: String, type: String, image: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.desc = desc
        self.comment = comment
        self.url = url
        self.type = type
        self.image = image
        self.coordinate = coordinate
        
        super.init()
    }
}