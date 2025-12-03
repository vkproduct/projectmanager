//
//  StatRow.swift
//  ProjectManager
//
//  Created by Antigravity on 2025-12-02.
//

import SwiftUI

struct StatRow: View {
    let icon: String
    let label: String
    let value: String
    let color: Color
    
    init(icon: String, label: String, value: String, color: Color = .secondaryLabel) {
        self.icon = icon
        self.label = label
        self.value = value
        self.color = color
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(color)
                .frame(width: 16)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.secondaryLabel)
            
            Spacer()
            
            Text(value)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.label)
        }
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    VStack(spacing: 12) {
        StatRow(icon: "clock", label: "Время", value: "25/40 ч", color: .blue)
        StatRow(icon: "star.fill", label: "Сложность", value: "⭐️⭐️⭐️⭐️", color: .orange)
        StatRow(icon: "exclamationmark.triangle", label: "Просрочено", value: "2", color: .red)
    }
    .padding()
    .background(Color(.systemBackground))
}
