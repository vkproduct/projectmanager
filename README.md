# Project Manager

A native iOS and macOS application for project and task management, built with SwiftUI and SwiftData.

## Features

### Core Functionality
- ✅ Create, edit, and delete projects with custom colors
- ✅ Manage tasks with deadlines, complexity ratings, and time tracking
- ✅ Automatic status calculation based on time spent
- ✅ Smart alert system for overdue tasks, upcoming deadlines, and workload
- ✅ Visual progress tracking with circular and linear indicators
- ✅ Comprehensive analytics for each project

### Platform Support
- **iOS 17.0+**: iPhone and iPad with adaptive layouts
- **macOS 14.0+**: Native Mac app with sidebar navigation

### Design
- Follows Apple Human Interface Guidelines
- Full Dark Mode and Light Mode support
- Dynamic Type for accessibility
- VoiceOver support
- System colors and components

## Project Structure

```
ProjectManager/
├── Models/
│   ├── Project.swift          # SwiftData project model
│   ├── Task.swift             # SwiftData task model
│   └── Alert.swift            # Alert structure
├── Services/
│   ├── DataService.swift      # SwiftData container
│   └── AnalyticsService.swift # Analytics and alerts
├── Views/
│   ├── iOS/                   # iOS-specific views
│   ├── macOS/                 # macOS-specific views
│   ├── Shared/                # Shared forms
│   └── Components/            # Reusable components
└── Utilities/
    ├── Extensions.swift       # Helper extensions
    └── Constants.swift        # App constants
```

## Requirements

- Xcode 15.0 or later
- iOS 17.0+ / macOS 14.0+
- Swift 5.9+

## Getting Started

### Creating the Xcode Project

Since Xcode projects cannot be created programmatically, you'll need to create the project manually:

1. Open Xcode
2. File → New → Project
3. Select "Multiplatform" → "App"
4. Product Name: `ProjectManager`
5. Interface: SwiftUI
6. Storage: SwiftData
7. Language: Swift
8. Save to: `/Users/vadim/projectmanager/ProjectManager`

Then, add all the Swift files from the `ProjectManager/ProjectManager/` directory to the project.

### Building from Command Line

**iOS:**
```bash
xcodebuild -scheme ProjectManager -destination 'platform=iOS Simulator,name=iPhone 15 Pro' build
```

**macOS:**
```bash
xcodebuild -scheme ProjectManager -destination 'platform=macOS' build
```

## Features in Detail

### Automatic Status Calculation
Task status is automatically determined based on time spent:
- **Не начато** (Not Started): spentHours = 0
- **В работе** (In Progress): 0 < spentHours < plannedHours
- **Завершено** (Completed): spentHours ≥ plannedHours

### Smart Alert System

**Critical Alerts (Red):**
- Overdue tasks
- Time exceeded on project

**Warning Alerts (Orange):**
- Upcoming deadlines (≤3 days)
- Too many complex tasks in progress
- Too many active tasks

**Info Alerts (Blue):**
- Low activity on project
- Ahead of schedule

### Data Persistence
- Uses SwiftData for local storage
- Automatic iCloud sync via CloudKit (when enabled)
- Sample data generated on first launch

## Accessibility

The app is fully accessible with:
- VoiceOver labels and hints
- Dynamic Type support
- Minimum 44pt touch targets
- Reduce Motion support
- High Contrast mode support

## Architecture

- **MVVM pattern** for separation of concerns
- **SwiftData** for data persistence
- **SwiftUI** for declarative UI
- **Multiplatform** codebase with platform-specific views

## Future Enhancements (Phase 2 & 3)

- [ ] iCloud synchronization
- [ ] Search and advanced filtering
- [ ] Widgets for iOS and macOS
- [ ] Live Activities (iOS)
- [ ] Push notifications for deadlines
- [ ] Export to CSV/PDF
- [ ] Shortcuts integration
- [ ] Siri integration
- [ ] Apple Watch companion app

## License

This project is created for personal use.

## Author

Created with Antigravity AI Assistant