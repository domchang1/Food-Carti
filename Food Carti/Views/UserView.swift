//
//  UserView.swift
//  Food Carti
//
//  Created by Dominic Chang on 11/26/24.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
               Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                .padding()
                VStack(alignment: .center) {
                    Text(viewModel.user.name)
                        .font(.system(size: 30))
                    Text(viewModel.user.email)
                }
            }
            Spacer()
        }
        .padding()
        .shadow(radius: 10)
        .background(Color.white.cornerRadius(10))
        
        // User Info Section
        Section("Favorite Food Carts") {
            ForEach(viewModel.favorited, id: \.self) { location in
                Label("\(location)", systemImage: "foodcart")
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .font(.system(size:30))
        .padding()
        .background(Color.white.cornerRadius(10))
        .shadow(radius: 10)
    }
}

//#Preview {
//    UserView()
//}
