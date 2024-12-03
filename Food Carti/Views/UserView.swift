//
//  UserView.swift
//  Food Carti
//
//  Created by Dominic Chang on 11/26/24.
//

import SwiftUI

import SwiftUI

struct UserView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var selectedLocation: Location?

    var body: some View {
        VStack(spacing: 20) {
            // User Info Section
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                        .padding()
                    Text(viewModel.user.name)
                        .font(.system(size: 30))
                        .bold()
                    Text(viewModel.user.email)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
            .background(Color.white.cornerRadius(10))
            .shadow(radius: 10)

            // Favorites Section
            VStack(alignment: .leading, spacing: 10) {
                Text("Favorite Food Carts")
                    .font(.headline)
                    .padding(.leading)

                if viewModel.favorited.isEmpty {
                    Text("No favorites yet!")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(Color.white.cornerRadius(10))
                        .shadow(radius: 10)
                } else {
                    List {
                        ForEach(viewModel.favorited, id: \.self) { favoriteName in
                            if let location = viewModel.locations.first(where: { $0.name == favoriteName }) {
                                Button(action: {
                                    withAnimation {
                                        selectedLocation = location
                                    }
                                }) {
                                    HStack {
                                        Label(location.name, systemImage: "star.fill")
                                            .font(.body)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                    .padding(10)
                                }
                            }
                        }
                        .onDelete { indices in
                            withAnimation {
                                for index in indices {
                                    viewModel.removeFavorite(location: viewModel.favorited[index])
                                }
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .frame(height: 300) // Adjust list height as needed
                }
            }
            .padding()
            .background(Color.white.cornerRadius(10))
            .shadow(radius: 10)

            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all)) // Clean background
        .sheet(item: $selectedLocation) { location in
            MapView(selectedLocation: location)
                .environmentObject(viewModel)
        }
    }
}



//#Preview {
//    UserView()
//}
