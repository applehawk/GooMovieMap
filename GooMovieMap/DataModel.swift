//
//  DataModel.swift
//  GooMovieMap
//
//  Created by Hawk on 31/03/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataModel {
    class func fromJSONToPlaces( jsonData : JSON ) -> [FunnyPlace]? {
        var places = [FunnyPlace]()
        
        if let jsonArrayPlaces = jsonData.array {
            for jsonPlace in jsonArrayPlaces {
                
                if let place = FunnyPlace.fromSwiftyJSONNetwork(jsonPlace) {
                    places.append(place)
                }
            }
        }
        return places
    }
    
    class func readJSONFileToPlaces( let fileName : String ) -> [FunnyPlace]? {
        guard let bundlefileName = NSBundle.mainBundle().pathForResource(fileName, ofType: "json") else {
            print("Filename: \(fileName) not available")
            return nil
        }
        guard let data = NSData(contentsOfFile: bundlefileName) else {
            print("Data isn't available")
            return nil
        }
        
        let jsonData = JSON(data: data)
        
        let places = fromJSONToPlaces( jsonData )
        
        return places
    }
}