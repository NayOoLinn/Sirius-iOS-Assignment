//
//  CityData.swift
//  SiriusiOSAssignment
//
//  Created by Nay Oo Linn on 06/10/2022.
//

import Foundation

struct CityData: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case country
        case name
        case coord
    }
    
    // MARK: Variables
    let id: Int?
    let country: String?
    let name: String?
    let coord: CoordinateData?
    
    // MARK: Mock Data
    static func mocks() -> [CityData] {
        var data = [
            CityData(id: 0, country: "a County", name: "a City", coord: .mock),
            CityData(id: 1, country: "A County", name: "A City", coord: .mock),
            CityData(id: 2, country: "b County", name: "b City", coord: .mock),
            CityData(id: 3, country: "B County", name: "B City", coord: .mock),
            CityData(id: 4, country: "c County", name: "c City", coord: .mock),
            CityData(id: 5, country: "C County", name: "C City", coord: .mock)
        ]
        data.shuffle()
        return data
    }
}

