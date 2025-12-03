# Quick Reference Guide

## Project Overview

**Project Manager** - Native iOS/macOS app for project and task management
- **Language**: Swift 5.9+
- **Framework**: SwiftUI
- **Storage**: SwiftData
- **Platforms**: iOS 17.0+, macOS 14.0+

## File Count
- **19 Swift files**
- **2,033 lines of code**
- **100% native** (no dependencies)

## Quick Start

### 1. Create Xcode Project
```
Xcode → New Project → Multiplatform → App
Name: ProjectManager
Storage: SwiftData ⚠️ IMPORTANT
Location: /Users/vadim/projectmanager/ProjectManager
```

### 2. Add Source Files
Drag these folders into Xcode:
- `Models/`
- `Services/`
- `Views/`
- `Utilities/`
- `ProjectManagerApp.swift`

### 3. Build & Run
- iOS: Select iPhone simulator, press ⌘R
- macOS: Select "My Mac", press ⌘R

## Key Features

### Automatic Status
Tasks automatically update status based on time:
- `spentHours = 0` → Not Started
- `0 < spentHours < plannedHours` → In Progress
- `spentHours ≥ plannedHours` → Completed

### Smart Alerts
Projects show alerts for:
- 🔴 **Critical**: Overdue tasks, time exceeded
- 🟠 **Warning**: Upcoming deadlines, too many tasks
- 🔵 **Info**: Low activity, ahead of schedule

### Adaptive UI
- **iPhone**: 1-2 columns
- **iPad**: 2-4 columns
- **macOS**: Sidebar + detail

## Project Structure

```
ProjectManager/
├── Models/              # SwiftData models
│   ├── Project.swift    # Project with analytics
│   ├── Task.swift       # Task with auto-status
│   └── Alert.swift      # Alert types
├── Services/
│   ├── DataService.swift      # SwiftData container
│   └── AnalyticsService.swift # Alert generation
├── Views/
│   ├── iOS/             # iPhone/iPad views
│   ├── macOS/           # Mac views
│   ├── Shared/          # Forms
│   └── Components/      # Reusable UI
└── Utilities/
    ├── Extensions.swift
    └── Constants.swift
```

## Important Files

### Entry Point
- [ProjectManagerApp.swift](file:///Users/vadim/projectmanager/ProjectManager/ProjectManager/ProjectManagerApp.swift) - App initialization

### Data Layer
- [Project.swift](file:///Users/vadim/projectmanager/ProjectManager/ProjectManager/Models/Project.swift) - Project model with analytics
- [Task.swift](file:///Users/vadim/projectmanager/ProjectManager/ProjectManager/Models/Task.swift) - Task with auto-status
- [DataService.swift](file:///Users/vadim/projectmanager/ProjectManager/ProjectManager/Services/DataService.swift) - SwiftData setup
- [AnalyticsService.swift](file:///Users/vadim/projectmanager/ProjectManager/ProjectManager/Services/AnalyticsService.swift) - Alert logic

### iOS Views
- [MainView.swift](file:///Users/vadim/projectmanager/ProjectManager/ProjectManager/Views/iOS/MainView.swift) - Project grid
- [ProjectCard.swift](file:///Users/vadim/projectmanager/ProjectManager/ProjectManager/Views/iOS/ProjectCard.swift) - Card design
- [ProjectDetailView.swift](file:///Users/vadim/projectmanager/ProjectManager/ProjectManager/Views/iOS/ProjectDetailView.swift) - Task list

### macOS Views
- [MainView.swift](file:///Users/vadim/projectmanager/ProjectManager/ProjectManager/Views/macOS/MainView.swift) - Split view
- [SidebarView.swift](file:///Users/vadim/projectmanager/ProjectManager/ProjectManager/Views/macOS/SidebarView.swift) - Sidebar

## Color Palette

10 system colors available:
- Teal (default)
- Blue
- Purple
- Pink
- Red
- Orange
- Yellow
- Green
- Indigo
- Mint

## Sample Data

App includes 3 sample projects:
1. **Мобильное приложение** (Blue) - 3 tasks
2. **Веб-сайт компании** (Purple) - 2 tasks
3. **Маркетинговая кампания** (Orange) - 3 tasks

## Testing Checklist

### iOS
- [ ] iPhone SE (small screen)
- [ ] iPhone 15 Pro Max (large screen)
- [ ] iPad (multiple columns)
- [ ] Dark/Light mode
- [ ] Dynamic Type
- [ ] VoiceOver
- [ ] Landscape/Portrait

### macOS
- [ ] Window resizing
- [ ] Sidebar navigation
- [ ] Context menus
- [ ] Keyboard shortcuts

## Common Issues

### "Cannot find type 'Project'"
→ Ensure all files added to both targets

### "No such module 'SwiftData'"
→ Check deployment target is iOS 17.0+/macOS 14.0+

### Files appear red
→ Re-add files with "Copy items if needed" checked

## Documentation

- [README.md](file:///Users/vadim/projectmanager/README.md) - Full documentation
- [SETUP_GUIDE.md](file:///Users/vadim/projectmanager/SETUP_GUIDE.md) - Detailed setup steps
- [walkthrough.md](file:///Users/vadim/.gemini/antigravity/brain/16b46529-d23e-4e94-996f-ff5cc46114d2/walkthrough.md) - Implementation details

## Next Steps

1. ✅ All source files created
2. ⏭️ Create Xcode project (see SETUP_GUIDE.md)
3. ⏭️ Add files to project
4. ⏭️ Build and run
5. ⏭️ Test on both platforms

## Optional Enhancements

Future phases can add:
- iCloud sync (infrastructure ready)
- Widgets
- Notifications
- Export features
- Shortcuts integration

---

**Status**: ✅ Phase 1 MVP Complete
**Ready to**: Create Xcode project and run
