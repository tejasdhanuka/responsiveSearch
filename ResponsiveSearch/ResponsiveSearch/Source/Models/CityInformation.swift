//
//  CityInformation.swift
//  ResponsiveSearch
//
//  Created by Tejas, Dhanuka on 2020/02/18.
//  Copyright © 2020 Tejas. All rights reserved.
//

import Foundation

// MARK: - City Information data protocol

public protocol CityInfoData {
    var name: String { get }
    var _id: Int { get }
    var country: String { get }
    var coord: LocationCoordinate  { get }
}

// MARK: - CityInfo object

public class CityInfo: Codable, CityInfoData {
    public let name: String
    public let _id: Int
    public let country: String
    public let coord: LocationCoordinate
}

extension CityInfo: TitleDetailProvider {
    var title: String {
        return "\(name), \(country)"
    }
    
    var detail: String {
        return "\(coord.lat), \(coord.lon)"
    }
}

extension CityInfo: LocationDataProvider {
    
    public var lat: Double {
        return coord.lat
    }
    
    public var lon: Double {
        return coord.lon
    }
}

// MARK: - LocationData protocol

public protocol LocationDataProvider {
    var lon: Double { get }
    var lat: Double { get }
}

// MARK: - LocationCoordinate object

public class LocationCoordinate: Codable, LocationDataProvider {
    public let lon: Double
    public let lat: Double
}
