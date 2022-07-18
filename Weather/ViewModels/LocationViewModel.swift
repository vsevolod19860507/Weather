//
//  LocationViewModel.swift
//  Weather
//
//  Created by Vsevolod R on 17.07.2022.
//

import MapKit

class LocationViewModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var selectedLocation = CLLocationCoordinate2D()
    @Published var currentRegion = MKCoordinateRegion()
    
    private var isLoaded = false
    
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !isLoaded {
            let location = locations.last!
            
            currentRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3)
            )
            
            selectedLocation = currentRegion.center
            
            isLoaded.toggle()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print (error)
    }
    
    func setSelectedLocation(at point: CGPoint, for mapSize: CGSize) {
        
        let lat = currentRegion.center.latitude
        let lon = currentRegion.center.longitude
        
        let mapCenter = CGPoint(x: mapSize.width / 2, y: mapSize.height / 2)
        
        let xValue = (point.x - mapCenter.x) / mapCenter.x
        let xSpan = xValue * currentRegion.span.longitudeDelta / 2
        
        let yValue = (point.y - mapCenter.y) / mapCenter.y
        let ySpan = yValue * currentRegion.span.latitudeDelta / 2
        
        selectedLocation = CLLocationCoordinate2D(latitude: lat - ySpan, longitude: lon + xSpan)
    }
}
