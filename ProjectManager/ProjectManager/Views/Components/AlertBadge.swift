//
//  AlertBadge.swift
//  ProjectManager
//
//  Created by Antigravity on 2025-12-02.
//

import SwiftUI

struct AlertBadge: View {
    let alert: ProjectAlert
    let compact: Bool
    
    init(alert: ProjectAlert, compact: Bool = false) {
        self.alert = alert
        self.compact = compact
    }
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: alert.icon)
                .font(.caption2)
            
            if !compact {
                Text(alert.message)
                    .font(.caption2)
                    .lineLimit(1)
            } else if let count = alert.count {
                Text("\(count)")
                    .font(.caption2)
                    .fontWeight(.semibold)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(alert.color.opacity(0.15))
        .foregroundColor(alert.color)
        .clipShape(Capsule())
        .accessibilityElement(children: .combine)
        .accessibilityLabel(alert.message)
    }
}

struct AlertBadgeList: View {
    let alerts: [ProjectAlert]
    let maxDisplay: Int
    
    init(alerts: [ProjectAlert], maxDisplay: Int = 2) {
        self.alerts = alerts
        self.maxDisplay = maxDisplay
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(Array(alerts.prefix(maxDisplay))) { alert in
                AlertBadge(alert: alert)
            }
            
            if alerts.count > maxDisplay {
                Text("+\(alerts.count - maxDisplay) еще")
                    .font(.caption2)
                    .foregroundColor(.secondaryLabel)
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        AlertBadge(alert: ProjectAlert(
            type: .critical,
            message: "Просрочено задач: 3",
            count: 3
        ))
        
        AlertBadge(alert: ProjectAlert(
            type: .warning,
            message: "Близкие дедлайны: 2 задач",
            count: 2
        ))
        
        AlertBadge(alert: ProjectAlert(
            type: .info,
            message: "Низкая активность: прогресс 25%",
            count: nil
        ))
        
        AlertBadge(alert: ProjectAlert(
            type: .critical,
            message: "Просрочено задач: 3",
            count: 3
        ), compact: true)
        
        Divider()
        
        AlertBadgeList(alerts: [
            ProjectAlert(type: .critical, message: "Просрочено задач: 3", count: 3),
            ProjectAlert(type: .warning, message: "Близкие дедлайны: 2 задач", count: 2),
            ProjectAlert(type: .info, message: "Низкая активность", count: nil)
        ])
    }
    .padding()
}
