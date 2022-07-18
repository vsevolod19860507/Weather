//
//  CLLocationCoordinate2D.swift
//  Weather
//
//  Created by Vsevolod R on 17.07.2022.
//

import MapKit

extension CLLocationCoordinate2D: Identifiable {
    public var id: Double { Double("\(latitude)-\(longitude)".hashValue) + latitude + longitude }
}
