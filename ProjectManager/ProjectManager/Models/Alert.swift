//
//  Alert.swift
//  ProjectManager
//
//  Created by Antigravity on 2025-12-02.
//

import Foundation
import SwiftUI

struct ProjectAlert: Identifiable {
    let id = UUID()
    let type: AlertType
    let message: String
    let count: Int?
    
    var color: Color {
        type.color
    }
    
    var icon: String {
        type.icon
    }
}

enum AlertType {
    case critical
    case warning
    case info
    
    var color: Color {
        switch self {
        case .critical: return .red
        case .warning: return .orange
        case .info: return .blue
        }
    }
    
    var icon: String {
        switch self {
        case .critical: return "exclamationmark.triangle.fill"
        case .warning: return "exclamationmark.circle.fill"
        case .info: return "info.circle.fill"
        }
    }
}
