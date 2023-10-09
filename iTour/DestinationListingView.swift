//
//  DestinationListingView.swift
//  iTour
//
//  Created by Julia Gurbanova on 09.10.2023.
//

import SwiftData
import SwiftUI

struct DestinationListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse),
                  SortDescriptor(\Destination.name)]) var destinations: [Destination]
    
    var body: some View {
        List {
            ForEach(destinations) { destination in
                NavigationLink(value: destination) {
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)

                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .onDelete(perform: deleteDestinations)
        }
    }

    init(sort: [SortDescriptor<Destination>], searchString: String = "", upcomingOnly: Bool = false) {
        let now = Date.now
        _destinations = Query(filter: #Predicate {
            (searchString.isEmpty || $0.name.localizedStandardContains(searchString)) &&
            (upcomingOnly == false || $0.date > now)
        }, sort: sort)
    }

    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: [SortDescriptor(\Destination.name)], searchString: "")
}
