# KaziHub Mobile App

A modern freelance marketplace mobile application built with SwiftUI for the Homeland Jobs Developer Assessment (Day 6 — Mobile Development).

## Features

### Home Tab

* Job feed with 15 mock Kenyan freelance jobs
* Real-time search filtering
* Pull-to-refresh functionality
* Bottom sheet filters (category + location)
* Skeleton loading state
* Job detail navigation

### My Applications Tab

* Static proposal list with status badges:

  * Pending
  * Viewed
  * Accepted
  * Rejected
* Notification badge count

### Messages Tab

* Mock conversations list
* Chat interface with sent/received message bubbles
* Unread message indicators

### Profile Tab

* User profile overview
* Skills chips
* Earnings summary
* Member since section
* Dark/light mode toggle with persistence

---

# M-Pesa Escrow Simulation

Implemented complete escrow funding flow:

1. Tap **Fund Escrow**
2. Payment modal opens
3. Enter phone number
4. Tap **Pay via M-Pesa**
5. 2-second loading spinner
6. Prompt state:

```txt id="90p20i"
Check your phone — M-Pesa prompt sent
```

7. Success state after 3 seconds:

```txt id="q9m6kr"
Escrow Funded Successfully
Receipt: NLJ7RT61SV
```

### Failure Simulation

* Toggle **Simulate Failure**
* Shows:

```txt id="h07s6n"
Payment failed — insufficient funds
```

* Includes Retry button

### Persistence

Payment state is persisted using `UserDefaults`:

* Receipt number
* Phone number
* Payment status
* Failure toggle state

---

# Tech Stack

* SwiftUI
* MVVM Architecture
* UserDefaults persistence
* NavigationStack
* Async UI simulation with DispatchQueue
* Native iOS animations and transitions

---

# Project Structure

```txt id="fwguxq"
KaziHub/
├── Models/
├── Services/
├── ViewModels/
├── Views/
│   ├── Applications/
│   ├── JobFeed/
│   ├── Messages/
│   ├── Payment/
│   └── Profile/
```

Architecture follows:

* Separation of concerns
* Reusable components
* MVVM pattern for scalability

---

# UI/UX Design

* Deep navy blue (#0A1628)
* Gold accent color (#F5A623)
* Glassmorphism cards
* Smooth spring animations
* Responsive layouts
* Native iOS feel

---

# Key Improvements Made

* Fixed gesture conflicts on JobCard taps
* Replaced custom long-press scaling with native `ButtonStyle`
* Added persistent payment recovery
* Improved navigation reliability
* Added proper loading and error states

---

# Running the Project

## Requirements

* Xcode 15+
* iOS 17+
* macOS Sonoma+

## Setup

```bash id="sod30f"
git clone <repo-url>
cd KaziHub
open KaziHub.xcodeproj
```

Then:

1. Select iPhone simulator
2. Press `Cmd + R`

---

# AI Tools Used

* ChatGPT
* Claude

Used for:

* Architecture planning
* UI refinement ideas
* README drafting
* Code review assistance

---

# Known Limitations

* Uses mock/local data only
* No real backend/API integration
* No real M-Pesa SDK integration
* No authentication flow implemented
* Notifications are simulated only

---
