//
//  MapUtility.swift
//  SiriusiOSAssignment
//
//  Created by Nay Oo Linn on 06/10/2022.
//

import MapKit
import UIKit

class MapUtility {
    
    static func openMap(
        with coordinate: (lat: Double, long: Double),
        name: String? = nil
    ) {
        guard canOpenAppleMap() else { return }
        openAppleMap(with: coordinate, name: name)
    }
    
    static func canOpenAppleMap() -> Bool {
        guard let url =  URL(string: "http://maps.apple.com/maps") else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
    
    static func openAppleMap(
        with coordinate: (lat: Double, long: Double),
        name: String? = nil
    ) {
        let coordinate = CLLocationCoordinate2D(
            latitude: coordinate.lat,
            longitude: coordinate.long
        )
        let mapItem = MKMapItem(
            placemark: MKPlacemark(
                coordinate: coordinate,
                addressDictionary:nil
            )
        )
        mapItem.name = name
        mapItem.openInMaps(launchOptions: nil)
    }
}
