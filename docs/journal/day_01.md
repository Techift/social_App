# Day 01 Journal – Code Audit

## Overview
Today I audited the social_app project. I reviewed the codebase, ran `flutter analyze` and `flutter test`, and identified several code smells and architectural issues.


## 1. Box deletion on startup

### What I observed
The app deletes locally stored data when it starts.

### Why this is wrong
This causes permanent data loss and breaks data persistence. Users expect their data to remain after reopening the app.

### Correct approach
Remove any `clear()` or `deleteBoxFromDisk()` logic from app initialization. Data should only be deleted when explicitly triggered by the user.


## 2. Empty password allowed

### What I observed
Users can submit authentication forms without entering a password.

### Why this is wrong
This creates a security vulnerability and allows invalid authentication attempts.

### Correct approach
Add input validation to ensure password field is not empty before submission.


## 3. No password verification

### What I observed
The system does not properly verify user passwords during login.

### Why this is wrong
This allows unauthorized access and breaks authentication security.

### Correct approach
Implement proper password comparison logic against stored credentials.


## 4. Hardcoded profile data

### What I observed
User profile information is hardcoded in the application.

### Why this is wrong
This prevents dynamic user data and makes the app non-scalable.

### Correct approach
Fetch user profile data from a database, API, or local storage.


## 5. Global state (_selectedImages)

### What I observed
Image selection state is declared at the top level.

### Why this is wrong
Global state makes the app harder to maintain and can cause unexpected behavior.

### Correct approach
Move state into proper state management (StatefulWidget, Provider, or controller).



## 6. Missing braces in if statements

### What I observed
Some `if` statements do not use curly braces.

### Why this is wrong
It reduces readability and increases risk of future bugs.

### Correct approach
Always wrap `if` blocks in `{}`.


## 7. Use of Container for spacing

### What I observed
Empty `Container` widgets are used for spacing.

### Why this is wrong
It is inefficient and not the recommended Flutter practice.

### Correct approach
Use `SizedBox` for spacing instead.


## 8. Missing widget keys

### What I observed
Some widgets do not include `key` parameters.

### Why this is wrong
Keys help Flutter efficiently rebuild widgets and prevent UI issues.

### Correct approach
Use `super.key` in all public widget constructors.


## 9. Critical Runtime Issue: Camera Image Upload Crash

### What I observed
The app crashes when an image is taken using the camera and uploaded as part of a post.

### Why this is serious
This affects a core feature of the application (post creation with images) and leads to a full app crash.

### Possible causes
- Missing permissions for camera or storage access
- Improper handling of image file returned from camera
- Large image causing memory overflow
- Async upload not properly awaited

### Expected behavior
Images captured from the camera should upload successfully without crashing the app.

### Next steps
Investigate image picker implementation, permission handling, and upload flow stability.


## Reflection
This audit helped me understand the importance of clean code, proper state management, and Flutter best practices. Most issues are not runtime errors but design and maintainability problems.

