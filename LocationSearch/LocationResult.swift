// File: LocationResult.swift Project: LocationSearch
// Created by: Prof. John Gallaugher on 11/23/24
// YouTube.com/profgallaugher  -  threads.net/john.gallaugher

import Foundation
import MapKit

struct LocationResult: Identifiable, Equatable {
    let id = UUID().uuidString
    let placeName: String
    let address: String
    let coordinates: CLLocationCoordinate2D
    
    // Make this struct Equatable so it can work with onChange
    static func == (lhs: LocationResult, rhs: LocationResult) -> Bool {
        lhs.id == rhs.id
    }
}
