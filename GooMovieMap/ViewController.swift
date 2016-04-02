//
//  ViewController.swift
//  GooMovieMap
//
//  Created by Hawk on 31/03/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet var locationsView: LocationsView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var descriptionText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationsView.handlerTapMaker = self.handlerTapMarker
        
        ServerRequests.requestPlaces { (places : [FunnyPlace]?) -> Void in
            if let places = places {
                for place in places {
                    self.locationsView.addMarker(place.title, snippet: place.comment, location: place.coordinate,
                        userData: place)
                }
            }
        }
        
    }
    
    func handlerTapMarker( place : AnyObject? ) -> Void {
        if let place = place as? FunnyPlace {
            imageView.downloadedFrom(link: place.image, contentMode: .ScaleAspectFit)
            descriptionText.text = place.desc
        }
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

