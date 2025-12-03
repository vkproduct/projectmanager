//
//  MainView.swift
//  ProjectManager (macOS)
//
//  Created by Antigravity on 2025-12-02.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State private var selectedProject: Project?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            SidebarView(selectedProject: $selectedProject)
                .navigationSplitViewColumnWidth(min: 200, ideal: 250, max: 300)
        } detail: {
            if let project = selectedProject {
                ProjectDetailView(project: project)
            } else {
                ContentUnavailableView(
                    "Выберите проект",
                    systemImage: "sidebar.left",
                    description: Text("Выберите проект из списка слева или создайте новый")
                )
            }
        }
    }
}

#Preview {
    MainView()
        .modelContainer(for: [Project.self, Task.self], inMemory: true)
        .frame(width: 1000, height: 700)
}
