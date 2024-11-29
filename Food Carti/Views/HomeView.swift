//
//  HomeView.swift
//  Food Carti
//
//  Created by Dominic Chang on 11/26/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        NavigationStack {
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
                        .buttonStyle(PlainButtonStyle()) // Prevent button animation style
                    }
                }
                .padding()
            }
            .navigationTitle("Your Feed")
        }
    }
}


#Preview {
    HomeView()
        .environmentObject(AppViewModel())
}

