// File: LocationSearchView.swift Project: LocationSearch
// Created by: Prof. John Gallaugher on 11/23/24
// YouTube.com/profgallaugher  -  threads.net/john.gallaugher

import SwiftUI

struct LocationSearchView: View {
    @Binding var selectedLocation: LocationResult?
    @State private var searchText: String = ""
    @State private var searchVM = LocationSearchViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List(searchVM.searchResults, id: \.self) { result in
                VStack (alignment: .leading) {
                    Text(result.title)
                    Text(result.subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .onTapGesture {
                    Task {
                        do {
                            selectedLocation = try await searchVM.returnLocationResult(for: result)
                            dismiss()
                        } catch {
                            searchVM.error = error
                        }
                    }
                }
            }
            .navigationTitle("Location Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $searchText)
        .autocorrectionDisabled()
        .onChange(of: searchText) {
            searchVM.updateSearchText(searchText)
        }
    }
}

#Preview {
    LocationSearchView(selectedLocation: .constant(nil))
}

