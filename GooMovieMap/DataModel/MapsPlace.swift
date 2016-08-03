//
//  MapsPlace.swift
//  GooMovieMap
//
//  Created by Hawk on 01/08/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import CoreLocation
import CoreFoundation


class GMPlacemark: NSObject {
    var title: String!
    var descr: String!
    var location: CLLocationCoordinate2D!
    var snippet: String!
    var imageUrls: [String]!
}

class GMPlacemarksFabric {
    
    func generatePlacemarks(kmlUrlString : String) -> [GMPlacemark] {
        let kmlRoot = KMLParser.parseKMLAtURL(NSURL(string: kmlUrlString));
        
        let kmlPlacemarks:NSArray = kmlRoot.placemarks();
        
        var placemarks = [GMPlacemark]()
        for kmlPlacemark in kmlPlacemarks as! [KMLPlacemark] {
            if let point = kmlPlacemark.geometry as? KMLPoint {
                let placemark = GMPlacemark();
                
                let latitude = (CLLocationDegrees)(point.coordinate.latitude)
                let longitude = (CLLocationDegrees)(point.coordinate.longitude)
                let snippet = kmlPlacemark.snippet
                let title = kmlPlacemark.name
                
                placemark.location =
                    CLLocationCoordinate2D(latitude: latitude,
                                           longitude: longitude)
                
                placemark.descr = kmlPlacemark.descriptionValue
                placemark.snippet = snippet
                placemark.title = title
                
                var imagesUrls = [String]()
                for data in (kmlPlacemark.extendedData.dataList as! [KMLData]) {
                    var separatedUrls = data.value.componentsSeparatedByString(" ")
                    for stringUrl in separatedUrls {
                        imagesUrls.append(stringUrl)
                    }
                }
                placemark.imageUrls = imagesUrls
                placemarks.append(placemark);
            }
        }
        
        return placemarks;
    }
}