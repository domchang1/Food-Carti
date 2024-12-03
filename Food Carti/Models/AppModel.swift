//
//  AppModel.swift
//  Food Carti
//
//  Created by Dominic Chang on 11/26/24.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let description: String
    let image: String
    var visited: Bool = false // New property to track visited status
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

struct Review: Identifiable, Codable {
    let id = UUID()
    let locationName: String
    let rating: Double
    let description: String
    let reviewer: String
}

struct User {
    var name: String
    var email: String
}
