//
//  MapsPlace.swift
//  GooMovieMap
//
//  Created by Hawk on 01/08/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import CoreLocation
import CoreFoundation


class MapsPlace: NSObject {
    let descr: String
    let coordinate: CLLocationCoordinate2D
    let images:[String]
    
    init(let descr:String, let coord:CLLocationCoordinate2D, images:[String]) {
        self.descr = descr
        self.coordinate = coord
        self.images = images
    }
}

class MapsPlacesFabric {
    
    func generateMapsPlacesFromKML(kmlString : String) -> [MapsPlace]? {
        
        let kmlUrl = NSURL(string: "http://www.google.com/maps/d/kml?forcekml=1&mid=1etOY__36A3eL47MRiE-gOCczF9M&lid=CLrURM2Sr_Y");
        
        let kmlRoot = KMLParser.parseKMLAtURL(kmlUrl);
        
        let kmlPlacemarks:NSArray = kmlRoot.placemarks();
        
        for placemark in kmlPlacemarks {
            let kmlPlacemark : KMLPlacemark? = placemark as! KMLPlacemark;
            print("Placemark \(kmlPlacemark?.descriptionValue)");
        }
        
        return nil;
    }
}