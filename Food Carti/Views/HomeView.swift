//
//  HomeView.swift
//  Food Carti
//
//  Created by Dominic Chang on 11/26/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Text("Your Feed")
            .padding()
            .fontWeight(.medium)
            .font(.system(size: 25))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    HomeView()
}
