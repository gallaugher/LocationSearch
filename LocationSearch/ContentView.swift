// File: ContentView.swift Project: LocationSearch
// Created by: Prof. John Gallaugher on 11/23/24
// YouTube.com/profgallaugher  -  threads.net/john.gallaugher

import SwiftUI
struct ContentView: View {
    @State var selectedLocation: LocationResult?
    @State private var sheetIsPresented = false
    var body: some View {
        VStack {
            if let returnedLocation = selectedLocation {
                VStack (alignment: .leading) {
                    Text(returnedLocation.placeName)
                        .font(.title2)
                    Text(returnedLocation.address)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                    Text("\(returnedLocation.coordinates.latitude),\(returnedLocation.coordinates.longitude)")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
            
            Spacer()
            
            Button {
                sheetIsPresented.toggle()
            } label: {
                Image(systemName: "location.magnifyingglass")
                Text("Location Search")
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
        }
        .sheet(isPresented: $sheetIsPresented) {
            LocationSearchView(selectedLocation: $selectedLocation)
        }
    }
}
#Preview {
    ContentView()
}
