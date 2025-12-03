//
//  TaskRow.swift
//  ProjectManager
//
//  Created by Antigravity on 2025-12-02.
//

import SwiftUI

struct TaskRow: View {
    let task: Task
    let onToggleComplete: () -> Void
    let onEdit: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header with checkbox and title
            HStack(alignment: .top, spacing: 12) {
                Button(action: onToggleComplete) {
                    Image(systemName: task.status == .completed ? "checkmark.circle.fill" : "circle")
                        .font(.title3)
                        .foregroundColor(task.status == .completed ? .green : .gray)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(task.status == .completed ? "Отметить как незавершенную" : "Отметить как завершенную")
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(task.title)
                        .font(.headline)
                        .foregroundColor(.label)
                        .strikethrough(task.status == .completed)
                    
                    if !task.taskDescription.isEmpty {
                        Text(task.taskDescription)
                            .font(.subheadline)
                            .foregroundColor(.secondaryLabel)
                            .lineLimit(2)
                    }
                }
                
                Spacer()
                
                // Status badge
                Text(task.status.rawValue)
                    .font(.caption2)
                    .fontWeight(.medium)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(task.status.systemColor).opacity(0.15))
                    .foregroundColor(Color(task.status.systemColor))
                    .clipShape(Capsule())
            }
            
            // Deadline
            HStack(spacing: 6) {
                Image(systemName: task.isOverdue ? "exclamationmark.triangle.fill" : "calendar")
                    .font(.caption)
                    .foregroundColor(task.isOverdue ? .red : .secondaryLabel)
                
                Text(task.deadline.relativeFormatted())
                    .font(.caption)
                    .foregroundColor(task.isOverdue ? .red : .secondaryLabel)
                
                if task.isOverdue {
                    Text("(просрочено)")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            
            // Complexity and time
            HStack(spacing: 16) {
                // Complexity stars
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                        .font(.caption2)
                        .foregroundColor(.orange)
                    Text(String(repeating: "⭐️", count: task.complexity))
                        .font(.caption)
                }
                
                // Time tracking
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.caption2)
                        .foregroundColor(.blue)
                    Text("\(task.spentHours.formatted(decimals: 1))/\(task.plannedHours.formatted(decimals: 1)) ч")
                        .font(.caption)
                        .foregroundColor(.secondaryLabel)
                }
                
                Spacer()
                
                // Action buttons
                HStack(spacing: 12) {
                    Button(action: onEdit) {
                        Image(systemName: "pencil")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Редактировать задачу")
                    
                    Button(action: onDelete) {
                        Image(systemName: "trash")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Удалить задачу")
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }
}

#Preview {
    VStack(spacing: 16) {
        TaskRow(
            task: Task(
                title: "Дизайн UI/UX",
                taskDescription: "Создать макеты всех экранов приложения",
                deadline: Date(),
                complexity: 4,
                plannedHours: 20,
                spentHours: 15
            ),
            onToggleComplete: {},
            onEdit: {},
            onDelete: {}
        )
        
        TaskRow(
            task: Task(
                title: "Тестирование",
                taskDescription: "",
                deadline: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
                complexity: 2,
                plannedHours: 10,
                spentHours: 0
            ),
            onToggleComplete: {},
            onEdit: {},
            onDelete: {}
        )
        
        TaskRow(
            task: Task(
                title: "Разработка API",
                taskDescription: "Реализовать REST API для бэкенда",
                deadline: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
                complexity: 5,
                plannedHours: 40,
                spentHours: 40
            ),
            onToggleComplete: {},
            onEdit: {},
            onDelete: {}
        )
    }
    .padding()
    .background(Color.systemGroupedBackground)
}
