//
//  HomeView.swift
//  Food Carti
//
//  Created by Dominic Chang on 11/26/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var showingAddReview = false // Control the add review sheet
    @State private var selectedLocationID: UUID? // Bind Picker to UUID
    @State private var rating = 5.0               // Default rating
    @State private var descriptionString = ""    // Review description

    var body: some View {
        NavigationStack {
            VStack {
                // Title
                Text("Your Feed")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()

                // Review List
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(viewModel.reviews) { review in
                            NavigationLink(destination: DetailedReviewView(review: review)) {
                                BoxView(
                                    rating: review.rating,
                                    name: review.locationName,
                                    description: review.description,
                                    reviewer: review.reviewer
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }

                // Add Review Button
                Button(action: {
                    selectedLocationID = viewModel.locations.first?.id // Default to first location's ID
                    showingAddReview = true
                }) {
                    Text("Add Review")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
            }
            .sheet(isPresented: $showingAddReview) {
                VStack(spacing: 20) {
                    // Title
                    Text("Add a Review")
                        .font(.headline)
                        .padding()

                    // Location Picker
                    Picker("Select Location", selection: $selectedLocationID) {
                        ForEach(viewModel.locations) { location in
                            Text(location.name).tag(location.id) // Bind to UUID
                        }
                    }
                    .pickerStyle(.menu)
                    .padding()

                    // Rating Slider
                    VStack {
                        Text("Rating: \(String(format: "%.1f", rating))")
                            .font(.subheadline)
                        Slider(value: $rating, in: 0...10, step: 0.1)
                            .padding()
                    }

                    // Review TextField
                    TextField("Write your review here...", text: $descriptionString)
                        .textFieldStyle(.roundedBorder)
                        .padding()

                    // Submit Button
                    Button(action: {
                        if let locationID = selectedLocationID,
                           let location = viewModel.locations.first(where: { $0.id == locationID }) {
                            let newReview = Review(
                                locationName: location.name,
                                rating: rating,
                                description: descriptionString,
                                reviewer: viewModel.username
                            )
                            viewModel.reviews.insert(newReview, at: 0) // Add to top of reviews
                            showingAddReview = false // Close the sheet
                            resetForm() // Reset form fields
                        }
                    }) {
                        Text("Submit Review")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                    }
                    .disabled(selectedLocationID == nil || descriptionString.isEmpty) // Disable if no input
                }
                .padding()
            }
        }
    }

    // Reset form fields after submission
    private func resetForm() {
        rating = 5.0
        descriptionString = ""
        selectedLocationID = nil
    }
}




#Preview {
    HomeView()
        .environmentObject(AppViewModel())
}

