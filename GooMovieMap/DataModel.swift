//
//  DataModel.swift
//  GooMovieMap
//
//  Created by Hawk on 31/03/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataModelMarkers {
    func readLocalfileToJSON( let fileName : String ) -> JSON {
        guard let bundlefileName = NSBundle.mainBundle().pathForResource(fileName, ofType: "json") else {
            print("Filename: \(fileName) not available")
            return nil
        }
        guard let data = NSData(contentsOfFile: bundlefileName) else {
            print("Data isn't available")
            return nil
        }
        
        let jsonData = JSON(data: data)
        
        return jsonData
    }
}