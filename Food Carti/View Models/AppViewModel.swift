//
//  AppViewModel.swift
//  Food Carti
//
//  Created by Dominic Chang on 11/26/24.
//

import Foundation
import CoreLocation

class AppViewModel: ObservableObject {
    var locations: [Location] = [
        Location(name: "Liam's Kitchen Daka", coordinate: CLLocationCoordinate2D(latitude: 39.952440, longitude: -75.199103), description: "An amazing and affordable Taiwanese food truck!"),
        Location(name: "Kim's Food Truck", coordinate: CLLocationCoordinate2D(latitude: 39.953916, longitude: -75.197531), description: "An amazing and convenient Chinese food truck!")]
}
