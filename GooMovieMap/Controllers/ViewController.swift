//
//  ViewController.swift
//  GooMovieMap
//
//  Created by Hawk on 31/03/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, LocationsViewProtocol {
    @IBOutlet weak var imageView: UIImageView!

    var placemarks : [GMPlacemark]!
    
    @IBOutlet var locationsView: LocationsView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var heightConstraintLocationsView: NSLayoutConstraint!
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var descriptionText: UITextView!

//Не размеры а доли экрана лучше!
    var expandedHeight : CGFloat?
    let constrictHeight : CGFloat = 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationsView.delegate = self
        
        heightConstraintLocationsView.constant = self.view.frame.size.height
        expandedHeight = heightConstraintLocationsView.constant
        self.view.updateConstraintsIfNeeded()
        
        loadPlacemarks()
    }
    
    func loadPlacemarks() {
        let fabric = GMPlacemarksFabric()
        self.placemarks = fabric.generatePlacemarks( GMConstants.MyMapsPS4 );
        
        for placemark in placemarks {
            var snippet = ""
            if(placemark.snippet != nil) {
                snippet = placemark.snippet
            }
            locationsView.addMarker(
                placemark.title,
                snippet: snippet,
                location: placemark.location,
                userData: placemark)
        }
    }
    
    func handlerTapCoordinate( coordinate : CLLocationCoordinate2D ) {
    }
    
    func handlerTapMarker(placemark : GMPlacemark?) {
        if let firstImage = placemark?.imageUrls.first as String?
        {
            imageView.downloadedFrom(
                link : firstImage,
                contentMode : UIViewContentMode.ScaleAspectFit)
        }
        descriptionText.text = placemark?.descr
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

