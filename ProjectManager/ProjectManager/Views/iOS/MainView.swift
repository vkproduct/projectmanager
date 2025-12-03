//
//  MainView.swift
//  ProjectManager (iOS)
//
//  Created by Antigravity on 2025-12-02.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @Query(sort: \Project.createdAt, order: .reverse) private var projects: [Project]
    
    @State private var showingProjectForm = false
    @State private var editingProject: Project?
    @State private var projectToDelete: Project?
    @State private var showingDeleteAlert = false
    
    var columns: [GridItem] {
        let columnCount: Int
        
        if horizontalSizeClass == .compact {
            columnCount = AppConstants.compactColumns
        } else {
            // iPad or large iPhone in landscape
            columnCount = AppConstants.regularColumns
        }
        
        return Array(repeating: GridItem(.flexible(), spacing: AppConstants.cardSpacing), count: columnCount)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if projects.isEmpty {
                    ContentUnavailableView(
                        "Нет проектов",
                        systemImage: "folder.badge.plus",
                        description: Text("Создайте свой первый проект, нажав кнопку +")
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 100)
                } else {
                    LazyVGrid(columns: columns, spacing: AppConstants.cardSpacing) {
                        ForEach(projects) { project in
                            NavigationLink {
                                ProjectDetailView(project: project)
                            } label: {
                                ProjectCard(project: project)
                            }
                            .buttonStyle(.plain)
                            .contextMenu {
                                Button {
                                    editingProject = project
                                } label: {
                                    Label("Редактировать", systemImage: "pencil")
                                }
                                
                                Button(role: .destructive) {
                                    projectToDelete = project
                                    showingDeleteAlert = true
                                } label: {
                                    Label("Удалить", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .background(Color.systemGroupedBackground)
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
            .sheet(item: $editingProject) { project in
                ProjectForm(project: project)
            }
            .alert("Удалить проект?", isPresented: $showingDeleteAlert) {
                Button("Отмена", role: .cancel) { }
                Button("Удалить", role: .destructive) {
                    if let project = projectToDelete {
                        deleteProject(project)
                    }
                }
            } message: {
                Text("Все задачи проекта также будут удалены. Это действие нельзя отменить.")
            }
        }
    }
    
    private func deleteProject(_ project: Project) {
        withAnimation {
            modelContext.delete(project)
            try? modelContext.save()
        }
    }
}

#Preview {
    MainView()
        .modelContainer(for: [Project.self, Task.self], inMemory: true)
}
