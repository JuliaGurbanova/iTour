//
//  ContentView.swift
//  iTour
//
//  Created by Julia Gurbanova on 09.10.2023.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = [Destination]()
    @State private var sortOrder = [SortDescriptor(\Destination.name), SortDescriptor(\Destination.date)]
    @State private var searchText = ""
    @State private var upcomingOnly = false

    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder, searchString: searchText, upcomingOnly: upcomingOnly)
                .navigationTitle("iTour")
                .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
                .searchable(text: $searchText)
                .toolbar {
                    Button("Add Destination", systemImage: "plus", action: addDestination)

                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder[0]) {
                            Text("Name")
                                .tag(SortDescriptor(\Destination.name))

                            Text("Priority")
                                .tag(SortDescriptor(\Destination.priority, order: .reverse))

                            Text("Date")
                                .tag(SortDescriptor(\Destination.date))
                        }
                        .pickerStyle(.inline)

                        Divider()

                        Picker("Upcoming Only", selection: $upcomingOnly) {
                            Text("All").tag(false)
                            Text("Upcoming Only").tag(true)
                        }
                    }
                }
        }
    }

    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }


}

#Preview {
    ContentView()
}
