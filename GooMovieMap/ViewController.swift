//
//  ViewController.swift
//  GooMovieMap
//
//  Created by Hawk on 31/03/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import UIKit
import GoogleMaps

/*
Подстановка собственной иконки на карте
Обработка нажатия на маркер для показа окошка
Информация о месте внизу карты
*/

class LocationsView : UIView {
    var mapView: GMSMapView!
    var controls: UISegmentedControl!
    
    static let honolulu = CLLocation(latitude: 21.282778, longitude: -157.829444)
    static let moscow = CLLocation(latitude: 55.6976543, longitude: 37.6599371)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        controls = UISegmentedControl(items: ["Normal", "Sattelite", "Hybrid"])
        mapView =  GMSMapView.mapWithFrame(CGRectZero, camera:
            LocationsView.makeGoogleCamera(LocationsView.moscow))
        
        controls.addTarget(self, action: "segmentedControlAction:", forControlEvents: .ValueChanged)
        
        self.addSubview(mapView)
        self.addSubview(controls)
    }
    
    override func didMoveToSuperview() {
        mapView.frame = self.frame
    }
    
    func activateConstraints() {
        controls.translatesAutoresizingMaskIntoConstraints = false;
        
        var allConstraints = [NSLayoutConstraint]()
        let viewsDict = ["controls": controls, "mapview" : mapView, "superview" : self ]
        
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-10-[controls]",
            options: [],
            metrics: nil,
            views: viewsDict)
        
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[mapview]-(<=1)-[controls]",
            options: [.AlignAllCenterX],
            metrics: nil,
            views: viewsDict)
        
        self.addConstraints(allConstraints)
    }
    
    func segmentedControlAction(sender: UISegmentedControl!) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            mapView.mapType = kGMSTypeNormal
        case 1:
            mapView.mapType = kGMSTypeSatellite
        default: // or case 2
            mapView.mapType = kGMSTypeHybrid
        }
    }

    
    class func makeGoogleCamera( location : CLLocation ) -> GMSCameraPosition {
        let camera = GMSCameraPosition.cameraWithLatitude(
            location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            zoom: 6.0)
        return camera
    }
    
    func addMarker( title: String, snippet: String, location : CLLocationCoordinate2D ) {
        let marker = GMSMarker()
        marker.position = location
        marker.title = title
        marker.snippet = snippet
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = mapView
    }
}
/*
class MapsViewService : UIView {
    let mapView : GMSMapView?
    
    required init?(coder aDecoder: NSCoder) {
        
        
        super.init(coder: aDecoder)
        
        self.addSubview( mapView! )
    }

}*/

class ViewController: UIViewController {

    @IBOutlet var locationsView: LocationsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //locationsView.setupView()
        
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
        
        locationsView.activateConstraints()
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

