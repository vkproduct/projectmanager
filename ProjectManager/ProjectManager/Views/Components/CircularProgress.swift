//
//  CircularProgress.swift
//  ProjectManager
//
//  Created by Antigravity on 2025-12-02.
//

import SwiftUI

struct CircularProgress: View {
    let progress: Double
    let tintColor: Color
    let lineWidth: CGFloat
    let size: CGFloat
    
    init(progress: Double, tintColor: Color = .teal, lineWidth: CGFloat = 8, size: CGFloat = 80) {
        self.progress = progress
        self.tintColor = tintColor
        self.lineWidth = lineWidth
        self.size = size
    }
    
    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: lineWidth)
            
            // Progress circle
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    tintColor,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.spring(response: 0.5, dampingFraction: 0.7), value: progress)
            
            // Percentage text
            VStack(spacing: 2) {
                Text("\(Int(progress * 100))")
                    .font(.system(size: size * 0.3, weight: .bold, design: .rounded))
                    .foregroundColor(.label)
                
                Text("%")
                    .font(.system(size: size * 0.15, weight: .medium))
                    .foregroundColor(.secondaryLabel)
            }
        }
        .frame(width: size, height: size)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Прогресс")
        .accessibilityValue("\(Int(progress * 100)) процентов")
    }
}

#Preview {
    VStack(spacing: 30) {
        CircularProgress(progress: 0.75, tintColor: .blue)
        CircularProgress(progress: 0.45, tintColor: .purple, size: 100)
        CircularProgress(progress: 0.25, tintColor: .orange, lineWidth: 10, size: 120)
    }
    .padding()
}
