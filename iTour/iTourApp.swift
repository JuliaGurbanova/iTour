//
//  iTourApp.swift
//  iTour
//
//  Created by Julia Gurbanova on 09.10.2023.
//

import SwiftData
import SwiftUI

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
