//
//  DetailedReviewView.swift
//  Food Carti
//
//  Created by Kevin Song on 11/29/24.
//
import SwiftUI

struct DetailedReviewView: View {
    let review: Review
    @EnvironmentObject var viewModel: AppViewModel
    @State private var navigateToMap = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Button(action: {
                    navigateToMap = true // Trigger navigation to the map
                }) {
                    Text(review.locationName)
                        .font(.largeTitle)
                        .bold()
                        .underline()
                }
                .foregroundColor(.blue)
                
                Spacer()
                ZStack {
                    Circle()
                        .fill(review.rating >= 7.0 ? Color.green : review.rating >= 4.0 ? Color.yellow : Color.red)
                        .frame(width: 50, height: 50)
                    Text(String(format: "%.1f", review.rating))
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            
            Text("Reviewer: \(review.reviewer)")
                .font(.title3)
                .foregroundColor(.gray)
            
            Text("Review")
                .font(.title2)
                .bold()
            
            Text(review.description)
                .font(.body)
                .padding()
            
            Spacer()
            
            // Navigation link to MapView
            NavigationLink(
                destination: MapView(selectedLocation: findLocation(for: review))
                    .environmentObject(viewModel),
                isActive: $navigateToMap
            ) {
                EmptyView()
            }
        }
        .padding()
        .navigationTitle("Review Details")
    }
    
    // Helper to find location for the review
    func findLocation(for review: Review) -> Location? {
        return viewModel.locations.first { $0.name == review.locationName }
    }
}
