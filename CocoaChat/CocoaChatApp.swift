//
//  CocoaChatApp.swift
//  CocoaChat
//
//  Created by Jimmy Ronaldo Macedo Pizango on 26/03/26.
//

import SwiftUI

@main
struct CocoaChatApp: App {
    private let dependencies = AppDependencies.live

    var body: some Scene {
        WindowGroup {
            ContentView(dependencies: dependencies)
                .tint(AppTheme.accent)
        }
    }
}
