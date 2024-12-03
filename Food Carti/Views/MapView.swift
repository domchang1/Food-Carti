//
//  MapView.swift
//  Food Carti
//
//  Created by Dominic Chang on 11/26/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var selectedLocation: Location?
    @State var showingPopUp = false

    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 39.9526, longitude: -75.198918),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    @State private var trackingMode: MapUserTrackingMode = .follow // User location tracking mode

    var body: some View {
        VStack {
            Text("Discover")
                .padding()
                .fontWeight(.medium)
                .font(.system(size: 25))
                .frame(maxWidth: .infinity, alignment: .leading)

            ZStack {
                // Display Map
                Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: $trackingMode, annotationItems: viewModel.locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        Button(action: {
                            // Handle click on a marker
                            selectedLocation = location
                            showingPopUp = true
                        }) {
                            VStack {
                                Text(location.name) // Display text for the marker
                                    .font(.caption)
                                    .foregroundColor(location.visited ? .green : .white) // Green if visited
                                    .padding(4)
                                    .background(location.visited ? Color.green.opacity(0.3) : Color.black.opacity(0.7))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image(systemName: "mappin.circle.fill") // Marker icon
                                    .foregroundColor(location.visited ? .green : .red) // Green pin if visited
                                    .font(.title)
                            }
                        }
                    }
                }
                .onAppear {
                    // Center the map on the user's location initially
                    if let userLocation = viewModel.userLocation {
                        region.center = userLocation
                    }
                }
                .onChange(of: viewModel.userLocation) { _ in
                    // Trigger the proximity check already in the view model
                    viewModel.checkProximity()
                }

                // Show Location Popup
                .sheet(isPresented: $showingPopUp) {
                    if let location = selectedLocation {
                        LocationPopupView(location: location)
                            .environmentObject(viewModel)
                            .presentationDetents([.medium])
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
        .padding(.bottom, 50) // Space for the navigation bar
    }
}




struct LocationPopupView: View {
    @EnvironmentObject var viewModel: AppViewModel
    let location: Location
    @State var addReview: Bool = false
    @State var addedReview: Bool = false
    @State var rating = 5.0
    @State var isEditing = false
    @State var descriptionString = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                Text(location.name)
                    .font(.title)
                    .bold()
                
                Text(location.description)
                    .font(.body)
                    //.frame(width: 25, height: 25)
                if !addReview {
                    Image(location.image)
                        .resizable()
                        .scaledToFit()
                    Button(action:{
                        withAnimation {
                            addReview.toggle()
                        }
                    }) {
                        Text("Add Review")
                            .padding()
                            .fontWeight(.medium)
                            .background(addedReview ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .disabled(addedReview)
                } else {
                    VStack {
                        Slider(
                            value: $rating,
                            in: 0...10,
                            step: 0.1
                        ) {
                            Text("Rating")
                        } minimumValueLabel: {
                            Text("0")
                        } maximumValueLabel: {
                            Text("10")
                        } onEditingChanged: { editing in
                            isEditing = editing
                        }
                        Text(String(format: "%.1f", rating))
                                .foregroundColor(isEditing ? .indigo : .blue)
                        TextField(
                            "Enter Description",
                            text: $descriptionString
                        )
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        Button(action: {
                            viewModel.addReview(
                                locationName: location.name,
                                rating: rating,
                                description: descriptionString,
                                reviewer: "Bob"
                            )
                            addReview = false
                            addedReview = true
                        }) {
                            Text("Submit")
                                .padding()
                                .fontWeight(.medium)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                    }
                    .transition(.scale)
                }
            }
            .padding()
            .navigationBarItems(trailing:
                                    HStack {
                Button("Close") {
                    dismiss()
                }
                if viewModel.favorited.contains(location.name) {
                   Button("Favorited", systemImage: "mappin.circle.fill") {
                       viewModel.removeFavorite(location:location.name)
                   }
                } else {
                    Button("Add to Favorite Locations", systemImage: "mappin.circle") {
                        viewModel.addFavorite(location:location.name)
                    }
                }
            })
        }
    }
}
//#Preview {
//    MapView().environmentObject(AppViewModel())
//}
