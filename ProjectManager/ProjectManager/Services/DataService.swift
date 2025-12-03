//
//  DataService.swift
//  ProjectManager
//
//  Created by Antigravity on 2025-12-02.
//

import Foundation
import SwiftData

class DataService {
    static let shared = DataService()
    
    let container: ModelContainer
    
    private init() {
        let schema = Schema([
            Project.self,
            Task.self
        ])
        
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false,
            cloudKitDatabase: .automatic // Enable iCloud sync
        )
        
        do {
            container = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    // Generate sample data for testing
    @MainActor
    static func generateSampleData(context: ModelContext) {
        // Check if data already exists
        let descriptor = FetchDescriptor<Project>()
        let existingProjects = try? context.fetch(descriptor)
        
        if let projects = existingProjects, !projects.isEmpty {
            return // Data already exists
        }
        
        // Create sample projects
        let project1 = Project(name: "Мобильное приложение", colorAccent: "Blue")
        let project2 = Project(name: "Веб-сайт компании", colorAccent: "Purple")
        let project3 = Project(name: "Маркетинговая кампания", colorAccent: "Orange")
        
        context.insert(project1)
        context.insert(project2)
        context.insert(project3)
        
        // Add tasks to project 1
        let task1 = Task(
            title: "Дизайн UI/UX",
            taskDescription: "Создать макеты всех экранов приложения",
            deadline: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
            complexity: 4,
            plannedHours: 20,
            spentHours: 25,
            project: project1
        )
        
        let task2 = Task(
            title: "Разработка API",
            taskDescription: "Реализовать REST API для бэкенда",
            deadline: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
            complexity: 5,
            plannedHours: 40,
            spentHours: 15,
            project: project1
        )
        
        let task3 = Task(
            title: "Тестирование",
            taskDescription: "Написать unit и integration тесты",
            deadline: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
            complexity: 3,
            plannedHours: 15,
            spentHours: 0,
            project: project1
        )
        
        context.insert(task1)
        context.insert(task2)
        context.insert(task3)
        
        // Add tasks to project 2
        let task4 = Task(
            title: "Контент-план",
            taskDescription: "Разработать структуру сайта и контент",
            deadline: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
            complexity: 2,
            plannedHours: 10,
            spentHours: 8,
            project: project2
        )
        
        let task5 = Task(
            title: "Верстка страниц",
            taskDescription: "HTML/CSS верстка всех страниц",
            deadline: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
            complexity: 3,
            plannedHours: 25,
            spentHours: 0,
            project: project2
        )
        
        context.insert(task4)
        context.insert(task5)
        
        // Add tasks to project 3
        let task6 = Task(
            title: "Анализ аудитории",
            taskDescription: "Исследование целевой аудитории",
            deadline: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
            complexity: 2,
            plannedHours: 8,
            spentHours: 8,
            project: project3
        )
        
        let task7 = Task(
            title: "Создание креативов",
            taskDescription: "Дизайн рекламных материалов",
            deadline: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
            complexity: 4,
            plannedHours: 16,
            spentHours: 10,
            project: project3
        )
        
        let task8 = Task(
            title: "Запуск рекламы",
            taskDescription: "Настройка и запуск рекламных кампаний",
            deadline: Calendar.current.date(byAdding: .day, value: 14, to: Date())!,
            complexity: 3,
            plannedHours: 12,
            spentHours: 0,
            project: project3
        )
        
        context.insert(task6)
        context.insert(task7)
        context.insert(task8)
        
        // Save context
        try? context.save()
    }
}
