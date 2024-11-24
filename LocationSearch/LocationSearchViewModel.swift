// File: LocationSearchViewModel.swift Project: LocationSearch
// Created by: Prof. John Gallaugher on 11/23/24
// YouTube.com/profgallaugher  -  threads.net/john.gallaugher

import Foundation
import MapKit

@Observable
class LocationSearchViewModel: NSObject, MKLocalSearchCompleterDelegate {
    private(set) var searchResults: [MKLocalSearchCompletion] = [] // Result of our search
    
    // This object takes in text to search on and returns the results in the value above
    private let completer = MKLocalSearchCompleter()
    
    var error: Error?
    
    // By adding the 'delegate' below, we're saying that 'completer' above can be automatically called by iOS when tasks need to be performed
    override init() {
        super.init()
        completer.delegate = self
    }
    
    // Adds typed text to the "competer" for processing & returning results
    func updateSearchText(_ text: String) {
        if text.isEmpty {
            searchResults = []
        }
        completer.queryFragment = text
    }
    
    
    // One of the tasks iOS will call on this delegate class. It will send back results returned from the completer
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
    }
    
    // Another one of the tasks iOS will call in case there is an error with the completer
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        self.error = error
    }
    
    // Return a LocationResult which contains lat & long coordaintes
    func returnLocationResult(for completion: MKLocalSearchCompletion) async throws -> LocationResult {
        // This gets the search request based on the completion - which is the result clicked on. It's named result in our app, but Apple uses the term 'completion', so we'll use it here, but it's our 'result' clicked on.
        let request = MKLocalSearch.Request(completion: completion)
        // Once we've set up our request, put it in an MKLocalSearch object so we can perform a search
        let search = MKLocalSearch(request: request)
        
        let response = try await search.start() // start the search
        guard let mapItem = response.mapItems.first else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No location found"])
        }
        
        return LocationResult(
            placeName: completion.title,
            address: completion.subtitle,
            coordinates: mapItem.placemark.coordinate
        )
    }
}
