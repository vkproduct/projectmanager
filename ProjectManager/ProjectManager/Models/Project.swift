//
//  Project.swift
//  ProjectManager
//
//  Created by Antigravity on 2025-12-02.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Project {
    var id: UUID
    var name: String
    var colorAccent: String
    var createdAt: Date
    
    @Relationship(deleteRule: .cascade, inverse: \Task.project)
    var tasks: [Task] = []
    
    init(name: String, colorAccent: String) {
        self.id = UUID()
        self.name = name
        self.colorAccent = colorAccent
        self.createdAt = Date()
    }
    
    // Computed properties for analytics
    var totalTasks: Int {
        tasks.count
    }
    
    var completedTasks: Int {
        tasks.filter { $0.status == .completed }.count
    }
    
    var activeTasks: Int {
        tasks.filter { $0.status == .inProgress }.count
    }
    
    var notStartedTasks: Int {
        tasks.filter { $0.status == .notStarted }.count
    }
    
    var progressPercentage: Double {
        guard totalTasks > 0 else { return 0 }
        return Double(completedTasks) / Double(totalTasks)
    }
    
    var totalPlannedHours: Double {
        tasks.reduce(0) { $0 + $1.plannedHours }
    }
    
    var totalSpentHours: Double {
        tasks.reduce(0) { $0 + $1.spentHours }
    }
    
    var averageComplexity: Double {
        guard !tasks.isEmpty else { return 0 }
        let sum = tasks.reduce(0) { $0 + $1.complexity }
        return Double(sum) / Double(tasks.count)
    }
    
    var overdueTasks: [Task] {
        tasks.filter { $0.isOverdue }
    }
    
    var overdueCount: Int {
        overdueTasks.count
    }
    
    var upcomingDeadlines: [Task] {
        let threeDaysFromNow = Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date()
        return tasks.filter { task in
            !task.isOverdue && task.deadline <= threeDaysFromNow && task.status != .completed
        }
    }
    
    var complexTasksInProgress: [Task] {
        tasks.filter { $0.complexity >= 4 && $0.status == .inProgress }
    }
    
    var timeOveragePercentage: Double {
        guard totalPlannedHours > 0 else { return 0 }
        let overage = totalSpentHours - totalPlannedHours
        return (overage / totalPlannedHours) * 100
    }
    
    var timeAheadPercentage: Double {
        guard totalPlannedHours > 0 else { return 0 }
        let ahead = totalPlannedHours - totalSpentHours
        return (ahead / totalPlannedHours) * 100
    }
    
    // Get accent color
    var accentColor: Color {
        ProjectColor.fromString(colorAccent).color
    }
}

// Predefined color palette
enum ProjectColor: String, CaseIterable {
    case teal = "Teal"
    case blue = "Blue"
    case purple = "Purple"
    case pink = "Pink"
    case red = "Red"
    case orange = "Orange"
    case yellow = "Yellow"
    case green = "Green"
    case indigo = "Indigo"
    case mint = "Mint"
    
    var color: Color {
        switch self {
        case .teal: return .teal
        case .blue: return .blue
        case .purple: return .purple
        case .pink: return .pink
        case .red: return .red
        case .orange: return .orange
        case .yellow: return .yellow
        case .green: return .green
        case .indigo: return .indigo
        case .mint: return .mint
        }
    }
    
    static func fromString(_ string: String) -> ProjectColor {
        ProjectColor(rawValue: string) ?? .teal
    }
}
