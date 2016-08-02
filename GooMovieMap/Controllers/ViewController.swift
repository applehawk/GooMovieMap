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
        
        locationsView.handlerTapMaker = self.handlerTapMarker
        locationsView.handlerTapCoordinate = self.handlerTapCoordinate
        
        heightConstraintLocationsView.constant = self.view.frame.size.height
        expandedHeight = heightConstraintLocationsView.constant
        self.view.updateConstraintsIfNeeded()
        
        loadPlacemarks()
    }
    
    func loadPlacemarks() {
        let fabric = GMPlacemarksFabric()
        self.placemarks = fabric.generatePlacemarks( GMConstants.MyMapsPS4 );
        
        for placemark in placemarks {
            locationsView.addMarker(
                placemark.descr,
                snippet: "",
                location: placemark.location,
                userData: placemark)
        }
    }
    
    func handlerTapCoordinate( coordinate : CLLocationCoordinate2D ) {
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(1.0) { () in
            if let height = self.expandedHeight {
                self.heightConstraintLocationsView.constant = height
            }
            self.view.layoutIfNeeded()
        }
    }
    
    func handlerTapMarker(placemark : GMPlacemark?) {
        /*
        if let place = place as? FunnyPlace {
            imageView.downloadedFrom(link: place.image, contentMode: .ScaleAspectFit)
            descriptionText.text = place.desc
            
            self.view.layoutIfNeeded()
            UIView.animateWithDuration(1.0) { () in
                self.heightConstraintLocationsView.constant = self.constrictHeight
                self.view.layoutIfNeeded()
            }
            
        }*/
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

