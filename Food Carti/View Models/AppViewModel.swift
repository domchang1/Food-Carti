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
        Location(name: "Liam's Kitchen Daka", coordinate: CLLocationCoordinate2D(latitude: 39.952440, longitude: -75.199103), description: "An amazing and affordable Taiwanese food truck!", image: "liams"),
        Location(name: "Kim's Food Truck", coordinate: CLLocationCoordinate2D(latitude: 39.953916, longitude: -75.197531), description: "An amazing and convenient Chinese food truck!", image: "kims"),
        Location(name: "Tyson Bees Food Truck", coordinate: CLLocationCoordinate2D(latitude: 39.950096, longitude: -75.191895), description: "A delicious and creative Asian Mexican fusion food truck!", image: "tysonbees"),
        Location(name: "Penn Halal Gyro on Locust", coordinate: CLLocationCoordinate2D(latitude: 39.952930, longitude: -75.202779), description: "A cheap and yummy Halal food truck!", image: "pennhalallocust"),
        Location(name: "Hemo's Food Truck", coordinate: CLLocationCoordinate2D(latitude: 39.950787, longitude: -75.195850), description: "A convenient and delicious breakfast/brunch food truck!", image: "hemos")
    ]
}
