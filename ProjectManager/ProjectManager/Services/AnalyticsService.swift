//
//  AnalyticsService.swift
//  ProjectManager
//
//  Created by Antigravity on 2025-12-02.
//

import Foundation

class AnalyticsService {
    
    // Generate alerts for a project based on defined rules
    static func generateAlerts(for project: Project) -> [ProjectAlert] {
        var alerts: [ProjectAlert] = []
        
        // CRITICAL ALERTS (Red)
        
        // Overdue tasks
        if project.overdueCount > 0 {
            alerts.append(ProjectAlert(
                type: .critical,
                message: "Просрочено задач: \(project.overdueCount)",
                count: project.overdueCount
            ))
        }
        
        // Time exceeded
        if project.timeOveragePercentage > 0 {
            let percentage = Int(project.timeOveragePercentage)
            alerts.append(ProjectAlert(
                type: .critical,
                message: "Время превышено на \(percentage)%",
                count: nil
            ))
        }
        
        // WARNING ALERTS (Orange)
        
        // Upcoming deadlines (≤3 days)
        let upcomingCount = project.upcomingDeadlines.count
        if upcomingCount > 0 {
            alerts.append(ProjectAlert(
                type: .warning,
                message: "Близкие дедлайны: \(upcomingCount) задач",
                count: upcomingCount
            ))
        }
        
        // Too many complex tasks in progress
        let complexCount = project.complexTasksInProgress.count
        if complexCount >= 3 {
            alerts.append(ProjectAlert(
                type: .warning,
                message: "Завал: \(complexCount) сложных задач одновременно",
                count: complexCount
            ))
        }
        
        // Too many tasks in progress
        if project.activeTasks > 5 {
            alerts.append(ProjectAlert(
                type: .warning,
                message: "Много задач в работе: \(project.activeTasks)",
                count: project.activeTasks
            ))
        }
        
        // INFO ALERTS (Blue)
        
        // Low activity (progress < 30% and has tasks)
        if project.totalTasks > 0 && project.progressPercentage < 0.3 {
            let percentage = Int(project.progressPercentage * 100)
            alerts.append(ProjectAlert(
                type: .info,
                message: "Низкая активность: прогресс \(percentage)%",
                count: nil
            ))
        }
        
        // Ahead of schedule
        if project.timeAheadPercentage > 10 && project.totalTasks > 0 {
            let percentage = Int(project.timeAheadPercentage)
            alerts.append(ProjectAlert(
                type: .info,
                message: "Опережаете график на \(percentage)%",
                count: nil
            ))
        }
        
        // Sort alerts by priority (critical first, then warning, then info)
        return alerts.sorted { alert1, alert2 in
            let priority1 = alertPriority(alert1.type)
            let priority2 = alertPriority(alert2.type)
            return priority1 < priority2
        }
    }
    
    private static func alertPriority(_ type: AlertType) -> Int {
        switch type {
        case .critical: return 0
        case .warning: return 1
        case .info: return 2
        }
    }
    
    // Get top N alerts for display on card
    static func getTopAlerts(for project: Project, limit: Int = 2) -> [ProjectAlert] {
        let allAlerts = generateAlerts(for: project)
        return Array(allAlerts.prefix(limit))
    }
    
    // Calculate total alert count
    static func totalAlertCount(for project: Project) -> Int {
        generateAlerts(for: project).count
    }
    
    // Recalculate all task statuses (called on app launch)
    static func recalculateTaskStatuses(tasks: [Task]) {
        // Status is computed property, so no action needed
        // This method exists for future enhancements
    }
}
