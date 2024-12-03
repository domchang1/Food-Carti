//
//  AppViewModel.swift
//  Food Carti
//
//  Created by Dominic Chang on 11/26/24.
//

import Foundation
import CoreLocation
import SwiftData

class AppViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locations: [Location] = [
        Location(name: "Liam's Kitchen Daka", coordinate: CLLocationCoordinate2D(latitude: 39.952440, longitude: -75.199103), description: "An amazing and affordable Taiwanese food truck!", image: "liams"),
        Location(name: "Kim's Food Truck", coordinate: CLLocationCoordinate2D(latitude: 39.953916, longitude: -75.197531), description: "An amazing and convenient Chinese food truck!", image: "kims"),
        Location(name: "Tyson Bees Food Truck", coordinate: CLLocationCoordinate2D(latitude: 39.950096, longitude: -75.191895), description: "A delicious and creative Asian Mexican fusion food truck!", image: "tysonbees"),
        Location(name: "Penn Halal Gyro on Locust", coordinate: CLLocationCoordinate2D(latitude: 39.952930, longitude: -75.202779), description: "A cheap and yummy Halal food truck!", image: "pennhalallocust"),
        Location(name: "Hemo's Food Truck", coordinate: CLLocationCoordinate2D(latitude: 39.950787, longitude: -75.195850), description: "A convenient and delicious breakfast/brunch food truck!", image: "hemos"),
        Location(name: "Tacos Don Memo", coordinate: CLLocationCoordinate2D(latitude: 39.95197702796157, longitude: -75.19926975474803), description: "A yummy Mexican food truck!", image: "tacosdonmemo"),
        Location(name: "Bui's Lunch Truck", coordinate: CLLocationCoordinate2D(latitude: 39.951656866004065, longitude: -75.19920484599017), description: "A convenient and delicious breakfast/lunch food truck!", image: "buis"),
        
    ]
    
    @Published var favorited: [String] = []
    

    let userDefaults = UserDefaults.standard
    var username = ""
    
    
    @Published var userLocation: CLLocationCoordinate2D? // Store user location
    
    private var locationManager: CLLocationManager
    
    @Published var reviews: [Review] = [] {
        didSet {
            saveReviews()
        }
    }

    override init() {
        self.locationManager = CLLocationManager()
        super.init()

        // Initialize location manager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        // Load persisted data
        favorited = userDefaults.stringArray(forKey: "favorited") ?? []
        username = userDefaults.string(forKey: "username") ?? ""
        reviews = loadReviews()
        if reviews.isEmpty {
                    addReview(locationName: "Tyson Bees", rating: 10.0, description: "Really yummy", reviewer: "Kevy Song")
                    addReview(locationName: "UPenn Gyro", rating: 5.0, description: "Disgusting", reviewer: "Big Rich")
                    addReview(locationName: "UPenn Gyro", rating: 0.8, description: "Actual garbage", reviewer: "Kevy Song")
                    addReview(locationName: "Tyson Bees", rating: 6.7, description: "I mean it’s alright", reviewer: "Big Rich")
        }

        print("Loaded favorites: \(favorited)")
    }

    func addUsername(name: String) {
        username = name
        userDefaults.set(username, forKey: "username")
    }
    
    // MARK: - Reviews Persistence
    private func saveReviews() {
        do {
            let data = try JSONEncoder().encode(reviews)
            userDefaults.set(data, forKey: "reviews")
            print("Saved reviews: \(reviews.count) reviews")
        } catch {
            print("Failed to save reviews: \(error)")
        }
    }

    private func loadReviews() -> [Review] {
        guard let data = userDefaults.data(forKey: "reviews") else { return [] }
        do {
            let decodedReviews = try JSONDecoder().decode([Review].self, from: data)
            print("Loaded reviews: \(decodedReviews.count) reviews")
            return decodedReviews
        } catch {
            print("Failed to load reviews: \(error)")
            return []
        }
    }

    // MARK: - Add Review
    func addReview(locationName: String, rating: Double, description: String, reviewer: String) {
        let newReview = Review(locationName: locationName, rating: rating, description: description, reviewer: reviewer)
        reviews.insert(newReview, at: 0)
    }
    
    
    // Delegate method to update user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            DispatchQueue.main.async {
                self.userLocation = location.coordinate // Update user location
            }
        }
    }
    
    // Delegate method to handle errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error)")
    }
    
    func addFavorite(location: String) {
        guard !favorited.contains(location) else { return } // Avoid duplicates
        favorited.append(location)
        userDefaults.set(favorited, forKey: "favorited")
        print("Added to favorites: \(location)")
    }

    func removeFavorite(location: String) {
        if let index = favorited.firstIndex(of: location) {
            favorited.remove(at: index)
            userDefaults.set(favorited, forKey: "favorited")
            print("Removed from favorites: \(location)")
        }
    }
    
}

