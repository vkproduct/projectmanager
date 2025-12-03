//
//  Constants.swift
//  ProjectManager
//
//  Created by Antigravity on 2025-12-02.
//

import Foundation
import SwiftUI

enum AppConstants {
    // Layout
    static let cardCornerRadius: CGFloat = 16
    static let cardPadding: CGFloat = 16
    static let cardSpacing: CGFloat = 16
    static let minCardWidth: CGFloat = 300
    
    // Grid columns
    static let compactColumns = 1
    static let regularColumns = 2
    static let largeColumns = 3
    static let extraLargeColumns = 4
    
    // Alert thresholds
    static let upcomingDeadlineDays = 3
    static let complexTaskThreshold = 4
    static let maxRecommendedActiveTasks = 5
    static let lowActivityThreshold = 0.3
    static let aheadOfScheduleThreshold = 10.0
    
    // Animation
    static let defaultAnimation: Animation = .default
    static let springAnimation: Animation = .spring(response: 0.3, dampingFraction: 0.7)
    
    // Accessibility
    static let minTouchTarget: CGFloat = 44
    
    // Colors
    static let availableColors = ProjectColor.allCases
}
