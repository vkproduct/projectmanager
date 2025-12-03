//
//  ProjectDetailView.swift
//  ProjectManager
//
//  Created by Antigravity on 2025-12-02.
//

import SwiftUI
import SwiftData

struct ProjectDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let project: Project
    
    @State private var filterSelection: TaskFilter = .all
    @State private var showingTaskForm = false
    @State private var editingTask: Task?
    @State private var taskToDelete: Task?
    @State private var showingDeleteAlert = false
    
    var filteredTasks: [Task] {
        let tasks = project.tasks
        switch filterSelection {
        case .all:
            return tasks
        case .active:
            return tasks.filter { $0.status != .completed }
        case .completed:
            return tasks.filter { $0.status == .completed }
        }
    }
    
    var sortedTasks: [Task] {
        filteredTasks.sorted { $0.deadline < $1.deadline }
    }
    
    var body: some View {
        List {
            // Project summary section
            Section {
                VStack(spacing: 16) {
                    HStack {
                        CircularProgress(
                            progress: project.progressPercentage,
                            tintColor: project.accentColor,
                            size: 80
                        )
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 8) {
                            VStack(alignment: .trailing, spacing: 4) {
                                Text("Задач выполнено")
                                    .font(.caption)
                                    .foregroundColor(.secondaryLabel)
                                Text("\(project.completedTasks) из \(project.totalTasks)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.label)
                            }
                            
                            VStack(alignment: .trailing, spacing: 4) {
                                Text("Затрачено времени")
                                    .font(.caption)
                                    .foregroundColor(.secondaryLabel)
                                Text("\(project.totalSpentHours.formatted(decimals: 1)) ч")
                                    .font(.headline)
                                    .foregroundColor(.label)
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            
            // Filter picker
            Section {
                Picker("Фильтр", selection: $filterSelection) {
                    ForEach(TaskFilter.allCases, id: \.self) { filter in
                        Text(filter.rawValue).tag(filter)
                    }
                }
                .pickerStyle(.segmented)
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
            
            // Tasks list
            Section {
                if sortedTasks.isEmpty {
                    ContentUnavailableView(
                        "Нет задач",
                        systemImage: "checklist",
                        description: Text(emptyStateMessage)
                    )
                } else {
                    ForEach(sortedTasks) { task in
                        TaskRow(
                            task: task,
                            onToggleComplete: {
                                toggleTaskCompletion(task)
                            },
                            onEdit: {
                                editingTask = task
                            },
                            onDelete: {
                                taskToDelete = task
                                showingDeleteAlert = true
                            }
                        )
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .listRowBackground(Color.clear)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                taskToDelete = task
                                showingDeleteAlert = true
                            } label: {
                                Label("Удалить", systemImage: "trash")
                            }
                            
                            Button {
                                editingTask = task
                            } label: {
                                Label("Изменить", systemImage: "pencil")
                            }
                            .tint(.blue)
                        }
                    }
                }
            }
        }
        .navigationTitle(project.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showingTaskForm = true
                } label: {
                    Label("Добавить задачу", systemImage: "plus")
                }
                .tint(project.accentColor)
            }
        }
        .sheet(isPresented: $showingTaskForm) {
            TaskForm(project: project)
        }
        .sheet(item: $editingTask) { task in
            TaskForm(project: project, task: task)
        }
        .alert("Удалить задачу?", isPresented: $showingDeleteAlert) {
            Button("Отмена", role: .cancel) { }
            Button("Удалить", role: .destructive) {
                if let task = taskToDelete {
                    deleteTask(task)
                }
            }
        } message: {
            Text("Это действие нельзя отменить.")
        }
    }
    
    private var emptyStateMessage: String {
        switch filterSelection {
        case .all:
            return "Добавьте первую задачу, нажав кнопку +"
        case .active:
            return "Нет активных задач"
        case .completed:
            return "Нет завершенных задач"
        }
    }
    
    private func toggleTaskCompletion(_ task: Task) {
        withAnimation {
            if task.status == .completed {
                // Mark as incomplete
                task.spentHours = task.plannedHours - 1
            } else {
                // Mark as complete
                task.spentHours = task.plannedHours
            }
            try? modelContext.save()
        }
    }
    
    private func deleteTask(_ task: Task) {
        withAnimation {
            modelContext.delete(task)
            try? modelContext.save()
        }
    }
}

enum TaskFilter: String, CaseIterable {
    case all = "Все"
    case active = "Активные"
    case completed = "Завершенные"
}

#Preview {
    NavigationStack {
        ProjectDetailView(project: Project(name: "Test Project", colorAccent: "Blue"))
    }
    .modelContainer(for: [Project.self, Task.self], inMemory: true)
}
