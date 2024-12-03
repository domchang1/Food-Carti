//
//  ContentView.swift
//  Food Carti
//
//  Created by Dominic Chang on 11/26/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var username: String = ""
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
        .clipShape(RoundedRectangle(cornerRadius: 10))
        if viewModel.username != "" {
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
        } else {
            Text("Please enter a username")
                        .padding()
                        .fontWeight(.medium)
                        .font(.system(size: 30))
                        .frame(maxWidth: .infinity, alignment: .init(horizontal: .center, vertical: .center))
                    TextField(
                            "Enter Name",
                            text: $username
                        )
                        .textFieldStyle(.roundedBorder)
                        .padding()
            Button(action: {
                viewModel.addUsername(name: username)
            }){
                            Text("Submit")
                                .padding()
                                    .fontWeight(.medium)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
        }
    }
}

#Preview {
    ContentView().environmentObject(AppViewModel())
}
