//
//  SidebarView.swift
//  ProjectManager (macOS)
//
//  Created by Antigravity on 2025-12-02.
//

import SwiftUI
import SwiftData

struct SidebarView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Project.createdAt, order: .reverse) private var projects: [Project]
    
    @Binding var selectedProject: Project?
    @State private var showingProjectForm = false
    
    var body: some View {
        List(selection: $selectedProject) {
            Section("Проекты") {
                ForEach(projects) { project in
                    NavigationLink(value: project) {
                        HStack(spacing: 12) {
                            Circle()
                                .fill(project.accentColor)
                                .frame(width: 12, height: 12)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(project.name)
                                    .font(.body)
                                
                                Text("\(project.completedTasks)/\(project.totalTasks) задач")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            // Alert badge
                            let alertCount = AnalyticsService.totalAlertCount(for: project)
                            if alertCount > 0 {
                                Text("\(alertCount)")
                                    .font(.caption2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Color.red)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    .contextMenu {
                        Button("Редактировать") {
                            // Edit project
                        }
                        
                        Divider()
                        
                        Button("Удалить", role: .destructive) {
                            deleteProject(project)
                        }
                    }
                }
            }
        }
        .navigationTitle("Проекты")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showingProjectForm = true
                } label: {
                    Label("Добавить проект", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingProjectForm) {
            ProjectForm()
        }
    }
    
    private func deleteProject(_ project: Project) {
        withAnimation {
            modelContext.delete(project)
            try? modelContext.save()
            if selectedProject?.id == project.id {
                selectedProject = nil
            }
        }
    }
}

#Preview {
    NavigationSplitView {
        SidebarView(selectedProject: .constant(nil))
    } detail: {
        Text("Select a project")
    }
    .modelContainer(for: [Project.self, Task.self], inMemory: true)
}
