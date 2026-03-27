//
//  ContentView.swift
//  CocoaChat
//
//  Created by Jimmy Ronaldo Macedo Pizango on 26/03/26.
//

import SwiftUI

struct AppDependencies {
    let chatInferenceService: any ChatInferenceServicing

    @MainActor
    func makeChatViewModel() -> ChatViewModel {
        ChatViewModel(service: chatInferenceService)
    }

    static let live = AppDependencies(
        chatInferenceService: CocoaLMChatService()
    )
}

struct ContentView: View {
    let dependencies: AppDependencies

    var body: some View {
        ChatScreen(
            viewModel: dependencies.makeChatViewModel()
        )
    }
}

#Preview {
    ContentView(dependencies: .live)
}
