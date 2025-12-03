//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Created by Antigravity on 2025-12-02.
//

import SwiftUI
import SwiftData

@main
struct ProjectManagerApp: App {
    let container: ModelContainer
    
    init() {
        self.container = DataService.shared.container
    }
    
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            MainView()
                .modelContainer(container)
                .onAppear {
                    setupSampleData()
                }
            #elseif os(macOS)
            MainView()
                .modelContainer(container)
                .onAppear {
                    setupSampleData()
                }
                .frame(minWidth: 800, minHeight: 600)
            #endif
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unified)
        .commands {
            CommandGroup(replacing: .newItem) {
                Button("Новый проект") {
                    // Handle new project
                }
                .keyboardShortcut("n", modifiers: .command)
            }
        }
        #endif
    }
    
    @MainActor
    private func setupSampleData() {
        let context = container.mainContext
        DataService.generateSampleData(context: context)
    }
}
