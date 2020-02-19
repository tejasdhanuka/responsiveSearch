//
//  DetailViewController.swift
//  ResponsiveSearch
//
//  Created by Tejas, Dhanuka on 2020/02/18.
//  Copyright © 2020 Tejas. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    static let annotationIdentifier = "CityAnnotation"
    var detailItem: TitleDetailProvider?

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.accessibilityIdentifier = "mapViewIdentifier"
        mapView.delegate = self
        configureView()
    }
    
    private func configureView() {
        // Update the user interface for the detail item.
        if let detailItem = detailItem {
            title = detailItem.title
    
            let annotation = MKPointAnnotation()
            annotation.title = detailItem.title
            annotation.subtitle = detailItem.detail
            
            guard let coordinates = detailItem as? LocationDataProvider else { return }
            annotation.coordinate = CLLocationCoordinate2DMake(coordinates.lat, coordinates.lon)
            mapView.addAnnotation(annotation)
            
            let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            mapView.setRegion(region, animated: true)
            mapView.selectAnnotation(annotation, animated: true)
            recursive(with: mapView)
        }
    }
    
    func recursive(with view: UIView) {
        if view.subviews.count > 0 {
            view.subviews.enumerated().forEach {
                $1.accessibilityIdentifier = "mapSubView-\($0)"
                recursive(with: $1)
            }
        }
    }

    // MARK: - MKMapViewDelegate protocol methods

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation { return nil }
        
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: DetailViewController.annotationIdentifier) {
            annotationView.annotation = annotation
            annotationView.accessibilityIdentifier = "annotationView"
            return annotationView
        } else {
            let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier: DetailViewController.annotationIdentifier)
            annotationView.isEnabled = true
            annotationView.canShowCallout = true
            annotationView.accessibilityIdentifier = "annotationView"
            return annotationView
        }
    }

}

