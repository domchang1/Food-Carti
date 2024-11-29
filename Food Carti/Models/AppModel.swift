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
    var reviews: [Review] = [] // Associated reviews

    static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id
    }
}


struct Review: Identifiable {
    let id = UUID()
    let locationName: String
    let rating: Double
    let description: String
    let reviewer: String
}
