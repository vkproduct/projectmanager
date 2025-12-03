# Xcode Project Setup Guide

Since Xcode project files cannot be created programmatically, follow these steps to set up the project:

## Step 1: Create New Xcode Project

1. Open **Xcode**
2. Select **File → New → Project** (or press ⌘⇧N)
3. In the template chooser:
   - Select **Multiplatform** tab at the top
   - Choose **App** template
   - Click **Next**

## Step 2: Configure Project Settings

Fill in the project details:

- **Product Name**: `ProjectManager`
- **Team**: Select your team (or leave as None for local development)
- **Organization Identifier**: `com.yourname` (or your preferred identifier)
- **Interface**: **SwiftUI**
- **Storage**: **SwiftData** ⚠️ IMPORTANT: Must select SwiftData
- **Language**: **Swift**
- **Include Tests**: ✓ (optional, but recommended)

Click **Next**

## Step 3: Choose Save Location

1. Navigate to: `/Users/vadim/projectmanager/`
2. **IMPORTANT**: The project will create a folder called `ProjectManager`
3. Click **Create**

Your project structure should now be:
```
/Users/vadim/projectmanager/
└── ProjectManager/              # Xcode created this
    ├── ProjectManager.xcodeproj
    └── ProjectManager/
        └── ProjectManagerApp.swift
```

## Step 4: Delete Default Files

Xcode creates some default files. Delete these (Move to Trash):

1. In Xcode's Project Navigator (left sidebar), select:
   - `ContentView.swift` (if exists)
   - `Item.swift` (if exists)
2. Right-click → **Delete**
3. Choose **Move to Trash**

## Step 5: Add Source Files

Now add all the Swift files we created:

### Method A: Drag and Drop (Easiest)

1. In Finder, open: `/Users/vadim/projectmanager/ProjectManager/ProjectManager/`
2. You should see folders: `Models/`, `Services/`, `Views/`, `Utilities/`
3. Select all these folders
4. Drag them into Xcode's Project Navigator under the `ProjectManager` group
5. In the dialog that appears:
   - ✓ **Copy items if needed**
   - ✓ **Create groups**
   - ✓ Select both targets: **ProjectManager (iOS)** and **ProjectManager (macOS)**
   - Click **Finish**

### Method B: Add Files Manually

1. Right-click on `ProjectManager` folder in Project Navigator
2. Select **Add Files to "ProjectManager"...**
3. Navigate to `/Users/vadim/projectmanager/ProjectManager/ProjectManager/`
4. Select the folders: `Models/`, `Services/`, `Views/`, `Utilities/`
5. Ensure:
   - ✓ **Copy items if needed**
   - ✓ **Create groups**
   - ✓ Add to targets: both iOS and macOS
6. Click **Add**

## Step 6: Replace App Entry Point

1. Open `ProjectManagerApp.swift` in Xcode (the one in the root of ProjectManager folder)
2. Replace its contents with the version from our created files
3. Or delete it and it should already be in the files you added

## Step 7: Configure Targets

### iOS Target

1. Select the project in Project Navigator (top item)
2. Select **ProjectManager (iOS)** target
3. Go to **General** tab:
   - **Minimum Deployments**: iOS 17.0
   - **Supported Destinations**: iPhone, iPad
4. Go to **Signing & Capabilities**:
   - Select your team (or use automatic signing)
   - (Optional) Add **iCloud** capability for CloudKit sync

### macOS Target

1. Select **ProjectManager (macOS)** target
2. Go to **General** tab:
   - **Minimum Deployments**: macOS 14.0
3. Go to **Signing & Capabilities**:
   - Select your team
   - (Optional) Add **iCloud** capability

## Step 8: Build and Run

1. Select a destination from the scheme selector:
   - For iOS: Choose an iPhone or iPad simulator
   - For macOS: Choose "My Mac"
2. Press **⌘R** to build and run
3. The app should launch with sample data

## Troubleshooting

### "Cannot find type 'Project' in scope"
- Make sure all files are added to both targets
- Check that files are in the correct groups
- Clean build folder: **Product → Clean Build Folder** (⌘⇧K)

### "No such module 'SwiftData'"
- Ensure deployment target is iOS 17.0+ or macOS 14.0+
- Check that you selected SwiftData when creating the project

### Files appear red in Project Navigator
- The files weren't copied properly
- Try Method A (drag and drop) again
- Ensure "Copy items if needed" was checked

### Build errors about duplicate symbols
- You may have duplicate files
- Check that you deleted the default `ContentView.swift` and `Item.swift`

## Verification

After setup, your Project Navigator should look like:

```
ProjectManager
├── ProjectManagerApp.swift
├── Models
│   ├── Project.swift
│   ├── Task.swift
│   └── Alert.swift
├── Services
│   ├── DataService.swift
│   └── AnalyticsService.swift
├── Views
│   ├── iOS
│   │   ├── MainView.swift
│   │   ├── ProjectCard.swift
│   │   └── ProjectDetailView.swift
│   ├── macOS
│   │   ├── MainView.swift
│   │   └── SidebarView.swift
│   ├── Shared
│   │   ├── TaskRow.swift
│   │   ├── ProjectForm.swift
│   │   └── TaskForm.swift
│   └── Components
│       ├── CircularProgress.swift
│       ├── StatRow.swift
│       └── AlertBadge.swift
└── Utilities
    ├── Extensions.swift
    └── Constants.swift
```

## Next Steps

Once the project builds successfully:

1. Run on iOS Simulator to test iPhone/iPad layouts
2. Run on macOS to test the sidebar navigation
3. Test Dark Mode (Settings → Appearance)
4. Test Dynamic Type (Settings → Accessibility → Larger Text)
5. Create your own projects and tasks!

## Optional: Enable iCloud Sync

1. In Xcode, select the project
2. Select a target
3. Go to **Signing & Capabilities**
4. Click **+ Capability**
5. Add **iCloud**
6. Check **CloudKit**
7. Repeat for the other target

Your data will now sync across devices signed into the same iCloud account!
