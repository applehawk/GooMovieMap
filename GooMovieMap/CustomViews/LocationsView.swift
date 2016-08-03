 //
//  LocationService.swift
//  GooMovieMap
//
//  Created by Hawk on 02/04/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import UIKit
import GoogleMaps

/*
Подстановка собственной иконки на карте
Обработка нажатия на маркер для показа окошка
Информация о месте внизу карты
*/
 
 protocol LocationsViewProtocol {
    func handlerTapMarker( placemark: GMPlacemark? )
    func handlerTapCoordinate (coordinate : CLLocationCoordinate2D)
 }
 
class LocationsView : UIView, GMSMapViewDelegate {
    var mapView: GMSMapView!
    var controls: UISegmentedControl?
    var delegate: LocationsViewProtocol?
    
    static let honolulu = CLLocation(latitude: 21.282778, longitude: -157.829444)
    static let moscow = CLLocation(latitude: 55.6976543, longitude: 37.6599371)
    
    override init(frame: CGRect) {
        print("init frame:")
        super.init(frame: frame)
        initSuperviewAndSubviews()
    }
    
    //var handlerTapMaker : HandlerTapMarker?
    func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
        if let delegate = delegate {
            if let placemark = marker.userData as? GMPlacemark {
                delegate.handlerTapMarker(placemark)
            }
        }
        return false
    }
    
    //var handlerTapCoordinate : HandlerTapCoordinate?
    func mapView(mapView: GMSMapView, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        if let delegate = delegate {
            delegate.handlerTapCoordinate( coordinate )
        }
    }
    
    func initSuperviewAndSubviews() {
        //controls = UISegmentedControl(items: ["Normal", "Sattelite", "Hybrid"])
        mapView =  GMSMapView.mapWithFrame(CGRectZero, camera:
            LocationsView.makeGoogleCamera(LocationsView.moscow))
        
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        
        self.addSubview(mapView)
        if mapView.superview?.description != self.description {
            print("is not equal \(mapView.superview?.description) and \(self.description)")
        } else {
            print("is  equal \(mapView.superview?.description) and \(self.description)")
        }
        
        mapView.translatesAutoresizingMaskIntoConstraints = false;
        
        if let controls = controls {
            self.addSubview(controls)
            controls.addTarget(self, action: "segmentedControlAction:", forControlEvents: .ValueChanged)
            controls.translatesAutoresizingMaskIntoConstraints = false;
        }
        
        self.updateContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("init? coder:")
        super.init(coder: aDecoder)
        initSuperviewAndSubviews()
    }
    
    func updateContraints() {
        print("updateContraints:")
        //print("Before Constraints: \(self.constraints)")
        
        var allConstraints = [NSLayoutConstraint]()
        var viewsDict = [
            "mapview" : mapView,
            "superview" : self
        ]
        
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[mapview]|",
            options: [.AlignAllCenterX, .AlignAllCenterY],
            metrics: nil,
            views: viewsDict)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[mapview]|",
            options: [.AlignAllCenterX, .AlignAllCenterY],
            metrics: nil,
            views: viewsDict)
        
        if (self.controls != nil) {
            viewsDict["controls"] = controls
        
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
        }
        self.addConstraints(allConstraints)
        
        //print("After Constraints: \(self.constraints)")
        
        
        super.updateConstraints()
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
    
    func addMarker(title : String,
                   snippet : String,
                   location : CLLocationCoordinate2D,
                   userData : AnyObject?) {
        let marker = GMSMarker()
        marker.position = location
        marker.title = title
        marker.snippet = snippet
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.userData = userData
        marker.icon = UIImage(named: "ps4icon")
        //marker.tappable = true
        
        marker.map = mapView
    }
}
