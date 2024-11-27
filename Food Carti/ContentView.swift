//
//  ContentView.swift
//  Food Carti
//
//  Created by Dominic Chang on 11/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView()
            }
            Tab("Map", systemImage: "map") {
                MapView()
            }
            Tab("User", systemImage: "person") {
                UserView()
            }
        }
    }
}

#Preview {
    ContentView()
}
