//
//  Extensions.swift
//  ProjectManager
//
//  Created by Antigravity on 2025-12-02.
//

import Foundation
import SwiftUI

// MARK: - Date Extensions
extension Date {
    func formatted(style: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: self)
    }
    
    func relativeFormatted() -> String {
        let calendar = Calendar.current
        let now = Date()
        
        if calendar.isDateInToday(self) {
            return "Сегодня"
        } else if calendar.isDateInTomorrow(self) {
            return "Завтра"
        } else if calendar.isDateInYesterday(self) {
            return "Вчера"
        } else {
            let components = calendar.dateComponents([.day], from: now, to: self)
            if let days = components.day {
                if days > 0 {
                    return "Через \(days) дн."
                } else {
                    return "\(abs(days)) дн. назад"
                }
            }
        }
        
        return formatted()
    }
}

// MARK: - View Extensions
extension View {
    func cardStyle() -> some View {
        self
            .background(Color(.systemBackground))
            .cornerRadius(AppConstants.cardCornerRadius)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// MARK: - Double Extensions
extension Double {
    func formatted(decimals: Int = 1) -> String {
        String(format: "%.\(decimals)f", self)
    }
}

// MARK: - Color Extensions
extension Color {
    static var systemGroupedBackground: Color {
        Color(.systemGroupedBackground)
    }
    
    static var secondarySystemGroupedBackground: Color {
        Color(.secondarySystemGroupedBackground)
    }
    
    static var label: Color {
        Color(.label)
    }
    
    static var secondaryLabel: Color {
        Color(.secondaryLabel)
    }
}
