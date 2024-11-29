//
//  BoxView.swift
//  Food Carti
//
//  Created by Kevin Song on 11/29/24.
//
import SwiftUI

struct BoxView: View {
    let rating: Double
    let name: String
    let description: String
    let reviewer: String
    
    var body: some View {
        HStack {
            // Circle with Rating
            ZStack {
                Circle()
                    .fill(rating >= 7.0 ? Color.green : rating >= 4.0 ? Color.yellow : Color.red)
                    .frame(width: 50, height: 50)
                
                Text(String(format: "%.1f", rating))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            
            // Food Truck Info
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Reviewer Name
            Text(reviewer)
                .font(.footnote)
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

