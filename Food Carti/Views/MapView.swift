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
    @State var index: MapSelection<Int>?
    let position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 39.9526, longitude: -75.198918),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )
    
    var body: some View {
        Text("Discover")
            .padding()
            .fontWeight(.medium)
            .font(.system(size: 25))
            .frame(maxWidth: .infinity, alignment: .leading)
        ZStack {
            MapReader { proxy in
                Map(initialPosition: position, selection: $index) {
                    ForEach(0..<viewModel.locations.count) { i in
                        Marker(viewModel.locations[i].name, coordinate: viewModel.locations[i].coordinate)
                            .tag(MapSelection(i))
    //                        .onTapGesture {
    //                            selectedLocation = location
    //                        }
                    }
                }
            }
            if let location = selectedLocation {
                LocationPopupView(location: location)
            }
        }
    }
}

struct LocationPopupView: View {
    let location: Location
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                Text(location.name)
                    .font(.title)
                    .bold()
                
                Text(location.description)
                    .font(.body)
                
                Spacer()
            }
            .padding()
            .navigationBarItems(trailing: Button("Close") {
                dismiss()
            })
        }
    }
}
//#Preview {
//    MapView().environmentObject(AppViewModel())
//}
