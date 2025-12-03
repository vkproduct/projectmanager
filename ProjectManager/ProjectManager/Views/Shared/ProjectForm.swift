//
//  ProjectForm.swift
//  ProjectManager
//
//  Created by Antigravity on 2025-12-02.
//

import SwiftUI
import SwiftData

struct ProjectForm: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    let project: Project?
    
    @State private var name: String = ""
    @State private var selectedColor: ProjectColor = .teal
    
    init(project: Project? = nil) {
        self.project = project
        if let project = project {
            _name = State(initialValue: project.name)
            _selectedColor = State(initialValue: ProjectColor.fromString(project.colorAccent))
        }
    }
    
    var isValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Основная информация") {
                    TextField("Название проекта", text: $name)
                        .accessibilityLabel("Название проекта")
                }
                
                Section("Цвет проекта") {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))], spacing: 12) {
                        ForEach(ProjectColor.allCases, id: \.self) { color in
                            ColorButton(
                                color: color,
                                isSelected: selectedColor == color,
                                action: { selectedColor = color }
                            )
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle(project == nil ? "Новый проект" : "Редактировать")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button(project == nil ? "Создать" : "Сохранить") {
                        saveProject()
                    }
                    .disabled(!isValid)
                }
            }
        }
    }
    
    private func saveProject() {
        if let project = project {
            // Edit existing
            project.name = name
            project.colorAccent = selectedColor.rawValue
        } else {
            // Create new
            let newProject = Project(name: name, colorAccent: selectedColor.rawValue)
            modelContext.insert(newProject)
        }
        
        try? modelContext.save()
        dismiss()
    }
}

struct ColorButton: View {
    let color: ProjectColor
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(color.color)
                    .frame(width: 50, height: 50)
                
                if isSelected {
                    Circle()
                        .strokeBorder(Color.primary, lineWidth: 3)
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: "checkmark")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(color.rawValue)")
        .accessibilityAddTraits(isSelected ? [.isSelected] : [])
    }
}

#Preview {
    ProjectForm()
}
