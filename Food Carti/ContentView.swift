//
//  ContentView.swift
//  Food Carti
//
//  Created by Dominic Chang on 11/26/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        HStack(alignment: .center) {
            Image("foodcart")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
            Text("Food Carti")
                .font(.title)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .foregroundStyle(.primary)
        .background(Color.gray.opacity(0.1))
//        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView().environmentObject(viewModel)
            }
            Tab("Map", systemImage: "map") {
                MapView().environmentObject(viewModel)
            }
            Tab("User", systemImage: "person") {
                UserView().environmentObject(viewModel)
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(AppViewModel())
}
