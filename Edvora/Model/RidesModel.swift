//
//  RidesModel.swift
//  Edvora
//
//  Created by Aakash Sinha on 04/03/22.
//

import Foundation

struct Ride: Identifiable, Codable, Hashable {
    var id: Int
    var originStationCode: Int
    var stationPath: [Int]
    var destinationStationCode: Int
    var date: String
    var mapURL: String
    var state, city: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case originStationCode = "origin_station_code"
        case stationPath = "station_path"
        case destinationStationCode = "destination_station_code"
        case date
        case mapURL = "map_url"
        case state, city
    }
}

struct RideSorted: Identifiable, Hashable, Comparable {
    var id: Int
    var distance: Int
    var originStationCode: Int
    var stationPath: [Int]
    var destinationStationCode: Int
    var date: String
    var mapURL: String
    var state, city: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case originStationCode = "origin_station_code"
        case stationPath = "station_path"
        case destinationStationCode = "destination_station_code"
        case date
        case mapURL = "map_url"
        case state, city
    }
    
    init(id: Int, distance: Int, originStationCode: Int, destinationStationCode: Int, date: String, mapURL: String, state: String, city: String, stationPath: [Int]){
        self.id = id
        self.distance = distance
        self.originStationCode = originStationCode
        self.destinationStationCode = destinationStationCode
        self.date = date
        self.mapURL = mapURL
        self.state = state
        self.city = city
        self.stationPath = stationPath
    }
    
    static func < (lhs: RideSorted, rhs: RideSorted) -> Bool {
        lhs.distance < rhs.distance
    }
    
}


