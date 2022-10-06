//
//  CityDetailRouter.swift
//  SiriusiOSAssignment
//
//  Created by Nay Oo Linn on 06/10/2022.
//

import Foundation

class CityDetailRouter: BaseRouter {
    func routeToMap(lat: Double?, lon: Double?, name: String?) {
        guard let lat = lat,
              let lon = lon else {
            return
        }
        
        MapUtility.openMap(
            with: (
                lat: lat,
                long: lon
            ),
            name: name
        )
    }
}

