//
//  ViewController.swift
//  GooMovieMap
//
//  Created by Hawk on 31/03/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var locationsView: LocationsView!
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let model = DataModelMarkers()
        
        let jsonValue = model.readLocalfileToJSON("Toilets")
        
        if let arrayToilets = jsonValue.array {
            for toilet in arrayToilets {
                
                if let toilet = Toilet.fromJSON(toilet) {
                    locationsView.addMarker(toilet.title!, snippet: toilet.subtitle!, location: toilet.coordinate)
                    //mapView.addAnnotation(toilet)
                }
            }
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

