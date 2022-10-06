//
//  CoordinateData.swift
//  SiriusiOSAssignment
//
//  Created by Nay Oo Linn on 06/10/2022.
//

import Foundation

struct CoordinateData: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case latDMS
        case lonDMS
    }
    
    // MARK: Variables
    let lat: Double?
    let lon: Double?
    var latDMS: String?
    var lonDMS: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lat = try container.decodeIfPresent(Double.self, forKey: .lat) ?? 0
        self.lon = try container.decodeIfPresent(Double.self, forKey: .lon) ?? 0
        self.latDMS = try container.decodeIfPresent(String.self, forKey: .latDMS) ?? ""
        self.lonDMS = try container.decodeIfPresent(String.self, forKey: .lonDMS) ?? ""
        setDMSString()
    }
    
    init(lat: Double, lon: Double, latDMS: String, lonDMS: String) {
        self.lat = lat
        self.lon = lon
        self.latDMS = latDMS
        self.lonDMS = lonDMS
    }
    
    mutating func setDMSString() {
        let dmsLat = getDMS(from: lat ?? 0)
        latDMS = String(
            format: "%d°%d'%d\"%@",
            abs(dmsLat.degrees),
            dmsLat.minutes,
            dmsLat.seconds,
            dmsLat.degrees >= 0 ? "N" : "S"
        )
        
        let dmsLon = getDMS(from: lon ?? 0)
        lonDMS =  String(
            format: "%d°%d'%d\"%@",
            abs(dmsLon.degrees),
            dmsLon.minutes,
            dmsLon.seconds,
            dmsLon.degrees >= 0 ? "E" : "W"
        )
    }
    
    func getDMS(from degree: Double) -> (degrees: Int, minutes: Int, seconds: Int) {
        var seconds = Int(degree * 3600)
        let degrees = seconds / 3600
        seconds = abs(seconds % 3600)
        return (degrees, seconds / 60, seconds % 60)
    }
    
    // MARK: Mock Data
    static let mock = CoordinateData(
        lat: 0,
        lon: 0,
        latDMS: "0°0'0\"N",
        lonDMS: "0°0'0\"E"
    )
}
