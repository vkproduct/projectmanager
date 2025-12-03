//
//  TaskForm.swift
//  ProjectManager
//
//  Created by Antigravity on 2025-12-02.
//

import SwiftUI
import SwiftData

struct TaskForm: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    let project: Project
    let task: Task?
    
    @State private var title: String = ""
    @State private var taskDescription: String = ""
    @State private var deadline: Date = Date()
    @State private var complexity: Int = 3
    @State private var plannedHours: Double = 8
    @State private var spentHours: Double = 0
    
    init(project: Project, task: Task? = nil) {
        self.project = project
        self.task = task
        
        if let task = task {
            _title = State(initialValue: task.title)
            _taskDescription = State(initialValue: task.taskDescription)
            _deadline = State(initialValue: task.deadline)
            _complexity = State(initialValue: task.complexity)
            _plannedHours = State(initialValue: task.plannedHours)
            _spentHours = State(initialValue: task.spentHours)
        }
    }
    
    var isValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty &&
        plannedHours > 0
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Основная информация") {
                    TextField("Название задачи", text: $title)
                        .accessibilityLabel("Название задачи")
                    
                    TextField("Описание (опционально)", text: $taskDescription, axis: .vertical)
                        .lineLimit(3...6)
                        .accessibilityLabel("Описание задачи")
                }
                
                Section("Параметры") {
                    DatePicker("Дедлайн", selection: $deadline, displayedComponents: .date)
                        .accessibilityLabel("Дедлайн задачи")
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Сложность")
                            Spacer()
                            Text(String(repeating: "⭐️", count: complexity))
                        }
                        
                        Slider(value: Binding(
                            get: { Double(complexity) },
                            set: { complexity = Int($0) }
                        ), in: 1...5, step: 1)
                        .tint(.orange)
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Сложность задачи")
                    .accessibilityValue("\(complexity) из 5")
                    
                    HStack {
                        Text("Планируемое время")
                        Spacer()
                        TextField("Часы", value: $plannedHours, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                        Text("ч")
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Планируемое время")
                    .accessibilityValue("\(plannedHours.formatted(decimals: 1)) часов")
                    
                    HStack {
                        Text("Затраченное время")
                        Spacer()
                        TextField("Часы", value: $spentHours, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                        Text("ч")
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Затраченное время")
                    .accessibilityValue("\(spentHours.formatted(decimals: 1)) часов")
                }
                
                Section {
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(.blue)
                        Text("Статус задачи определяется автоматически на основе затраченного времени")
                            .font(.caption)
                            .foregroundColor(.secondaryLabel)
                    }
                }
            }
            .navigationTitle(task == nil ? "Новая задача" : "Редактировать")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button(task == nil ? "Создать" : "Сохранить") {
                        saveTask()
                    }
                    .disabled(!isValid)
                }
            }
        }
    }
    
    private func saveTask() {
        if let task = task {
            // Edit existing
            task.title = title
            task.taskDescription = taskDescription
            task.deadline = deadline
            task.complexity = complexity
            task.plannedHours = plannedHours
            task.spentHours = spentHours
        } else {
            // Create new
            let newTask = Task(
                title: title,
                taskDescription: taskDescription,
                deadline: deadline,
                complexity: complexity,
                plannedHours: plannedHours,
                spentHours: spentHours,
                project: project
            )
            modelContext.insert(newTask)
        }
        
        try? modelContext.save()
        dismiss()
    }
}

#Preview {
    TaskForm(project: Project(name: "Test Project", colorAccent: "Blue"))
        .modelContainer(for: [Project.self, Task.self], inMemory: true)
}
