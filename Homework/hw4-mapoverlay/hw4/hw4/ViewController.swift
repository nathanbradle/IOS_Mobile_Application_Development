//
//  ViewController.swift
//  hw4
//
//  Created by Nathan Wangidjaja on 10/23/23.
//

import UIKit
import Foundation
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapTitle: UILabel!

    struct countyItem: Decodable {
        let type: String
        let features: [Feature]
    }

    struct Feature: Decodable {
        let type: String
        let properties: Properties
        let geometry: Geometry
    }

    struct Geometry: Decodable {
        let type: String
        let coordinates: [[[Double]]]
    }

    struct Properties: Decodable {
        let zipCodes, state, counties: [String]
    }
    var allVals:[countyItem] = []
    var namecounty: [String] = ["brevard"]
    var arrayCoord: [CLLocationCoordinate2D] = []
    var locManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapTitle.text = "Brevard"
        self.getAllData()
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        self.renderMapOverlay(allVals: arrayCoord)

    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locManager.startUpdatingLocation()
        }
        if status == .denied || status == .notDetermined{
            locManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locManager.stopUpdatingLocation()
    }

    func renderMapOverlay(allVals: [CLLocationCoordinate2D]) {
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let currAnnotation = MKPointAnnotation()
        currAnnotation.coordinate = CLLocationCoordinate2D(latitude: 28.320007, longitude: -80.607552)
        mapView.addAnnotation(currAnnotation)
        currAnnotation.title = "Cocoa Beach"
        let polyline = MKPolyline(coordinates: allVals, count: allVals.count)
        mapView.addOverlay(polyline)
        let cocoa = CLLocationCoordinate2D(latitude: 28.320007, longitude: -80.607552)
        let startRegion = MKCoordinateRegion(center: cocoa, span: span)
        mapView.setRegion(startRegion, animated: true)
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let path = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: path)
            renderer.strokeColor = UIColor.blue.withAlphaComponent(8)
            renderer.lineWidth = 4
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    func getAllData() {
        let headers = [
            "X-RapidAPI-Key": "87cf09d72fmsh79349eb7285c980p13f7fcjsn42e02ea3e65f",
            "X-RapidAPI-Host": "vanitysoft-boundaries-io-v1.p.rapidapi.com"
        ]
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: NSURL(string: "https://vanitysoft-boundaries-io-v1.p.rapidapi.com/reaperfire/rest/v1/public/boundary/county/brevard/state/fl")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                
            guard error == nil else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error - ", message: "No Network Connection", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                return
            }
            guard let jsonData = data else {
                print("Data Not Available")
                return
            }
                
            do {
                let decoder = JSONDecoder()
                let dataCounty = try decoder.decode(countyItem.self, from: jsonData)

                for coord in dataCounty.features[0].geometry.coordinates[0] {
                    let coordinate = CLLocationCoordinate2D(latitude: coord[1], longitude: coord[0])
                    self.arrayCoord.append(coordinate)
                }
                    
                DispatchQueue.main.async {
                    self.renderMapOverlay(allVals: self.arrayCoord)
                }
                    
            } catch {
                print("JSON Decode error: \(error)")
            }
                
        })
        dataTask.resume()
            
    }
}


