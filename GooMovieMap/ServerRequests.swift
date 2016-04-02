//
//  ServerRequests.swift
//  GooMovieMap
//
//  Created by Hawk on 02/04/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ServerRequests {
    /*http://alias-android.ru/streettip/rest/ex.php/tips */
    
    typealias requestPlacesHandler = ( places: [FunnyPlace]? ) -> Void
    
    class func requestPlaces( requestHandler : requestPlacesHandler ) {
        Alamofire.request(.GET, "http://alias-android.ru/streettip/rest/ex.php/tips", parameters: nil)
            .responseJSON { response in
                
                if let jsonString = response.result.value {
                    print("JSON: \(jsonString)")
                    
                    let places = DataModel.fromJSONToPlaces( JSON(jsonString) )
                    requestHandler(places: places)
                } else {
                    requestHandler(places: nil)
                }
        }
    }
}