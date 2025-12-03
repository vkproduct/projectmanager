//
//  Task.swift
//  ProjectManager
//
//  Created by Antigravity on 2025-12-02.
//

import Foundation
import SwiftData

@Model
final class Task {
    var id: UUID
    var title: String
    var taskDescription: String
    var deadline: Date
    var complexity: Int // 1-5
    var plannedHours: Double
    var spentHours: Double
    var createdAt: Date
    
    var project: Project?
    
    init(title: String, 
         taskDescription: String = "",
         deadline: Date,
         complexity: Int,
         plannedHours: Double,
         spentHours: Double = 0,
         project: Project? = nil) {
        self.id = UUID()
        self.title = title
        self.taskDescription = taskDescription
        self.deadline = deadline
        self.complexity = min(max(complexity, 1), 5) // Clamp between 1-5
        self.plannedHours = plannedHours
        self.spentHours = spentHours
        self.createdAt = Date()
        self.project = project
    }
    
    // Computed status based on spent hours
    var status: TaskStatus {
        if spentHours == 0 {
            return .notStarted
        } else if spentHours < plannedHours {
            return .inProgress
        } else {
            return .completed
        }
    }
    
    // Check if task is overdue
    var isOverdue: Bool {
        deadline < Date() && status != .completed
    }
    
    // Days until deadline
    var daysUntilDeadline: Int {
        Calendar.current.dateComponents([.day], from: Date(), to: deadline).day ?? 0
    }
    
    // Progress percentage
    var progressPercentage: Double {
        guard plannedHours > 0 else { return 0 }
        return min(spentHours / plannedHours, 1.0)
    }
    
    // Remaining hours
    var remainingHours: Double {
        max(plannedHours - spentHours, 0)
    }
}

enum TaskStatus: String, Codable {
    case notStarted = "Не начато"
    case inProgress = "В работе"
    case completed = "Завершено"
    
    var systemColor: String {
        switch self {
        case .notStarted: return "gray"
        case .inProgress: return "blue"
        case .completed: return "green"
        }
    }
}
