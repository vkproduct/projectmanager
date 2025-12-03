//
//  ProjectCard.swift
//  ProjectManager
//
//  Created by Antigravity on 2025-12-02.
//

import SwiftUI

struct ProjectCard: View {
    let project: Project
    
    var alerts: [ProjectAlert] {
        AnalyticsService.generateAlerts(for: project)
    }
    
    var topAlerts: [ProjectAlert] {
        AnalyticsService.getTopAlerts(for: project, limit: 2)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header with circular progress
            HStack(alignment: .top, spacing: 16) {
                CircularProgress(
                    progress: project.progressPercentage,
                    tintColor: project.accentColor,
                    size: 70
                )
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(project.name)
                        .font(.headline)
                        .foregroundColor(.label)
                        .lineLimit(2)
                    
                    // Task counter
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.caption)
                            .foregroundColor(project.accentColor)
                        Text("\(project.completedTasks)/\(project.totalTasks)")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.label)
                    }
                    
                    // Progress bar
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 6)
                            
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            project.accentColor.opacity(0.7),
                                            project.accentColor
                                        ],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: geometry.size.width * project.progressPercentage, height: 6)
                                .animation(.spring(response: 0.5), value: project.progressPercentage)
                        }
                    }
                    .frame(height: 6)
                }
                
                Spacer(minLength: 0)
            }
            
            Divider()
            
            // Statistics
            VStack(spacing: 8) {
                StatRow(
                    icon: "clock",
                    label: "Время",
                    value: "\(project.totalSpentHours.formatted(decimals: 1))/\(project.totalPlannedHours.formatted(decimals: 1)) ч",
                    color: .blue
                )
                
                StatRow(
                    icon: "star.fill",
                    label: "Средняя сложность",
                    value: String(repeating: "⭐️", count: Int(project.averageComplexity.rounded())),
                    color: .orange
                )
                
                if project.overdueCount > 0 {
                    StatRow(
                        icon: "exclamationmark.triangle.fill",
                        label: "Просрочено",
                        value: "\(project.overdueCount)",
                        color: .red
                    )
                }
            }
            
            // Alerts
            if !topAlerts.isEmpty {
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "bell.fill")
                            .font(.caption)
                            .foregroundColor(.secondaryLabel)
                        Text("Уведомления")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.secondaryLabel)
                        
                        Spacer()
                        
                        if alerts.count > 2 {
                            Text("+\(alerts.count - 2)")
                                .font(.caption2)
                                .foregroundColor(.secondaryLabel)
                        }
                    }
                    
                    AlertBadgeList(alerts: topAlerts, maxDisplay: 2)
                }
            }
        }
        .padding(AppConstants.cardPadding)
        .background(Color(.systemBackground))
        .cornerRadius(AppConstants.cardCornerRadius)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: AppConstants.cardCornerRadius)
                .strokeBorder(project.accentColor.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview {
    let project = Project(name: "Мобильное приложение", colorAccent: "Blue")
    
    let task1 = Task(
        title: "Дизайн UI/UX",
        deadline: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
        complexity: 4,
        plannedHours: 20,
        spentHours: 25,
        project: project
    )
    
    let task2 = Task(
        title: "Разработка API",
        deadline: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
        complexity: 5,
        plannedHours: 40,
        spentHours: 15,
        project: project
    )
    
    let task3 = Task(
        title: "Тестирование",
        deadline: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
        complexity: 3,
        plannedHours: 15,
        spentHours: 0,
        project: project
    )
    
    return ProjectCard(project: project)
        .padding()
        .background(Color.systemGroupedBackground)
}
