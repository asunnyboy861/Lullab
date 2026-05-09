# Git Repositories

## Main App (iOS Application)

| Item | Value |
|------|-------|
| **Repository Name** | Lullab |
| **Git URL** | git@github.com:asunnyboy861/Lullab.git |
| **Repo URL** | https://github.com/asunnyboy861/Lullab |
| **Visibility** | Public |
| **Primary Language** | Swift |
| **GitHub Pages** | ENABLED (from `/docs` folder) |

## Policy Pages (Deployed from Main Repository /docs)

| Page | URL | Status |
|------|-----|--------|
| Landing Page | https://asunnyboy861.github.io/Lullab/ | Active |
| Support | https://asunnyboy861.github.io/Lullab/support.html | Active |
| Privacy Policy | https://asunnyboy861.github.io/Lullab/privacy.html | Active |
| Terms of Use | https://asunnyboy861.github.io/Lullab/terms.html | Active |

## Repository Structure

```
Lullab/
├── Lullab/                        # iOS App Source Code
│   ├── Lullab.xcodeproj/          # Xcode Project
│   ├── Lullab/                    # Swift Source Files
│   │   ├── LullabApp.swift        # App Entry Point
│   │   ├── DesignSystem/
│   │   │   ├── Colors.swift
│   │   │   ├── Typography.swift
│   │   │   └── Components.swift
│   │   ├── Models/
│   │   │   ├── EventModels.swift
│   │   │   ├── CDEvent+CoreData.swift
│   │   │   └── CDBaby+CoreData.swift
│   │   ├── Services/
│   │   │   ├── PersistenceController.swift
│   │   │   ├── SubscriptionManager.swift
│   │   │   ├── LiveActivityManager.swift
│   │   │   └── FeedbackService.swift
│   │   ├── ViewModels/
│   │   │   ├── HomeViewModel.swift
│   │   │   ├── FeedViewModel.swift
│   │   │   ├── SleepViewModel.swift
│   │   │   ├── DiaperViewModel.swift
│   │   │   ├── GrowthViewModel.swift
│   │   │   └── TimelineViewModel.swift
│   │   ├── Views/
│   │   │   ├── Home/
│   │   │   │   └── HomeView.swift
│   │   │   ├── Feed/
│   │   │   │   └── FeedDetailView.swift
│   │   │   ├── Sleep/
│   │   │   │   └── SleepDetailView.swift
│   │   │   ├── Diaper/
│   │   │   │   └── DiaperDetailView.swift
│   │   │   ├── Growth/
│   │   │   │   └── GrowthDetailView.swift
│   │   │   ├── Timeline/
│   │   │   │   └── TimelineView.swift
│   │   │   ├── Settings/
│   │   │   │   ├── SettingsView.swift
│   │   │   │   ├── PremiumPaywallView.swift
│   │   │   │   └── ContactSupportView.swift
│   │   │   └── Onboarding/
│   │   │       └── OnboardingView.swift
│   │   ├── Extensions/
│   │   │   └── Date+Formatting.swift
│   │   ├── Lullab.xcdatamodeld/   # Core Data Model
│   │   └── Assets.xcassets/       # App Icons & Colors
│   ├── LullabTests/
│   └── LullabUITests/
├── docs/                          # Policy Pages (GitHub Pages source)
│   ├── landing.html
│   ├── support.html
│   ├── privacy.html
│   └── terms.html
├── .github/workflows/
│   └── deploy.yml
├── us.md
├── keytext.md
├── capabilities.md
├── icon.md
├── price.md
└── nowgit.md
```
