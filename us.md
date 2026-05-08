# Lullab - iOS Development Guide

## Executive Summary

**Lullab** is a dark-first, minimalist newborn tracker designed for exhausted parents who need to log feedings, sleep, diapers, and growth in the fewest possible taps — even at 3 AM, one-handed, half-asleep. Unlike competitors that overwhelm with features, Lullab tracks only four essential things and makes each one-tap simple.

**Product Vision**: The calmest, simplest newborn tracker on the App Store. Zero learning curve. Zero ads. Zero guilt.

**Target Audience**: First-time parents in the US market (ages 25-38) who are overwhelmed by complex baby tracking apps and need a tool that works at 3 AM without waking their partner.

**Key Differentiators**:
- Dark-first design philosophy (not inverted light mode — designed from scratch for OLED)
- 1-tap quick log (3 seconds to record any event vs. 4-6 taps in competitors)
- Zero ads forever, even in the free tier
- CloudKit sync included in free tier (competitors charge for sync)
- Live Activity for sleep/feed timers (persists when leaving the app)
- Subscription at $2.99/month — lowest in category

## Competitive Analysis

| App | Strengths | Weaknesses | Our Advantage |
|-----|-----------|------------|---------------|
| **Cubtale** | Smart hardware buttons, WHO percentiles, AI sleep windows, expert consultants | Requires hardware for best experience, complex feature set | Lullab is simpler, no hardware dependency, zero learning curve |
| **Huckleberry** | SweetSpot sleep predictor, sleep training plans | $9.99-14.99/month, sync only in paid tier, complex UI | Lullab is 3x cheaper, sync in free tier, dark-first design |
| **Baby Tracker (Nighp)** | Free, most reviews, watch support | Intrusive ads, unreliable sync, outdated UI, no dark mode | Lullab has zero ads, CloudKit sync, modern dark-first UI |
| **Tinylog** | WHO + Fenton charts, AI insights, no ads | $9.99/month, premium-only sync | Lullab is 3x cheaper, free sync, simpler interface |
| **Sprout Baby** | WHO growth charts, milestone tracking, PDF export | $14.99-19.99/month, $59.99-89.99/year, complex | Lullab is 5x cheaper monthly, far simpler, dark-first |
| **Glow Baby** | Community features, growth percentiles | Privacy concerns (California lawsuit), ads, data collection | Lullab is privacy-first, no third-party SDKs, no ads |

### Market Positioning

```
Price (monthly subscription) from low to high:
Baby Bloom    $0.99  ██████
Lullab        $2.99  ██████████████████
nappi         $3.99  ████████████████████████
Baby Daybook  $5.99  ████████████████████████████████
Huckleberry   $9.99  ████████████████████████████████████████████████████████████
Tinylog       $9.99  ████████████████████████████████████████████████████████████
Babee.ai     $12.99  ██████████████████████████████████████████████████████████████████████████
Sprout       $14.99  ████████████████████████████████████████████████████████████████████████████████████████
```

Lullab: Second-lowest price, but free tier includes sync + Live Activity + Widget — far beyond same-price competitors.

## Apple Design Guidelines Compliance

### Human Interface Guidelines (HIG)

- **Dark Mode**: Lullab is dark-first, not dark-optional. The entire UI is designed for OLED pure black (#000000) backgrounds. Light mode is supported but secondary, following system appearance settings.
- **Minimum Touch Target**: All interactive elements meet 44x44pt minimum (HIG standard). Quick-log tiles are significantly larger for one-handed use.
- **Dynamic Type**: All text supports Dynamic Type scaling. Typography uses `.rounded` design for warmth and approachability.
- **VoiceOver**: Full VoiceOver support with meaningful labels on all interactive elements.
- **Haptics**: UIImpactFeedbackGenerator for quick-log taps, providing tactile confirmation.
- **Navigation**: TabBar with 3 tabs (Home, Timeline, Settings) following HIG tab bar patterns. Detail views use sheet presentation, not push navigation.
- **Live Activities**: Sleep and feed timers use ActivityKit for lock screen/Dynamic Island display, following HIG Live Activity guidelines.
- **Widgets**: Home screen and lock screen widgets via WidgetKit, following HIG widget design guidelines.

### App Store Review Guidelines Compliance

- **Guideline 1.4 (Physical Harm)**: Lullab is a wellness/tracking tool, not a medical device. App includes disclaimer that it is not a substitute for professional medical advice. Growth charts use WHO standards for reference only.
- **Guideline 2.1 (Performance)**: App is fully functional with no placeholder screens or "coming soon" features.
- **Guideline 3.1.1 (In-App Purchase)**: Premium subscription uses StoreKit 2. Restore Purchases button is prominently placed in Settings and Paywall.
- **Guideline 5.1.1 (Privacy)**: Privacy policy linked in App Store metadata and within the app. No third-party analytics SDKs. Data stored locally-first with CloudKit private database sync.
- **Guideline 5.1.3 (Health Data)**: App does not make medical claims. Growth tracking is for reference only. App reminds users to consult their pediatrician.
- **Health & Fitness Category**: Starting spring 2026, apps in Medical or Health & Fitness category must indicate regulatory status. Lullab is a wellness tracker, not a regulated medical device.

### Privacy & Data Protection

- **No third-party SDKs**: Zero analytics, zero ad SDKs, zero social SDKs
- **Local-first architecture**: Core Data stores everything locally before syncing
- **CloudKit Private Database**: All sync data is in user's private iCloud database — Apple cannot read it
- **No account creation**: Uses iCloud identity automatically — no email, no password, no sign-up
- **App Groups**: Widget data sharing via secure App Group container

## Technical Architecture

- **Language**: Swift 5.10+
- **Framework**: SwiftUI (primary), ActivityKit, WidgetKit, StoreKit 2, Swift Charts
- **Data**: Core Data + NSPersistentCloudKitContainer + App Groups
- **Sync**: CloudKit Private Database + Custom Zone + Change Token Tracking
- **Concurrency**: Modern Swift concurrency (async/await, Actors)
- **Minimum iOS**: 17.0
- **Platforms**: iOS 17+, watchOS 10+ (future), WidgetKit

## Module Structure

```
Lullab/
├── LullabApp.swift
├── Views/
│   ├── Home/
│   │   ├── HomeView.swift
│   │   ├── QuickLogTile.swift
│   │   ├── BabyHeaderView.swift
│   │   ├── LastEventBar.swift
│   │   └── TodayTimelineView.swift
│   ├── Feed/
│   │   ├── FeedLogView.swift
│   │   ├── FeedDetailView.swift
│   │   └── FeedTypePicker.swift
│   ├── Sleep/
│   │   ├── SleepLogView.swift
│   │   ├── SleepDetailView.swift
│   │   └── SleepTimerView.swift
│   ├── Diaper/
│   │   ├── DiaperLogView.swift
│   │   ├── DiaperDetailView.swift
│   │   └── DiaperTypePicker.swift
│   ├── Growth/
│   │   ├── GrowthLogView.swift
│   │   ├── GrowthDetailView.swift
│   │   └── GrowthChartView.swift
│   ├── Timeline/
│   │   ├── TimelineView.swift
│   │   ├── TimelineEventRow.swift
│   │   └── TimelineFilterView.swift
│   ├── Settings/
│   │   ├── SettingsView.swift
│   │   ├── BabyProfileView.swift
│   │   ├── DoctorReportView.swift
│   │   └── PremiumPaywallView.swift
│   └── Onboarding/
│       ├── OnboardingView.swift
│       └── BabySetupView.swift
├── ViewModels/
│   ├── HomeViewModel.swift
│   ├── FeedViewModel.swift
│   ├── SleepViewModel.swift
│   ├── DiaperViewModel.swift
│   ├── GrowthViewModel.swift
│   ├── TimelineViewModel.swift
│   └── SettingsViewModel.swift
├── Models/
│   ├── Event+CoreData.swift
│   ├── Baby+CoreData.swift
│   ├── FeedMetadata.swift
│   ├── SleepMetadata.swift
│   ├── DiaperMetadata.swift
│   └── GrowthMetadata.swift
├── Services/
│   ├── PersistenceController.swift
│   ├── CloudKitSyncService.swift
│   ├── LiveActivityManager.swift
│   ├── DoctorReportGenerator.swift
│   └── SubscriptionManager.swift
├── DesignSystem/
│   ├── Colors.swift
│   ├── Typography.swift
│   ├── Components.swift
│   └── LullabButton.swift
├── Widgets/
│   ├── LullabWidget.swift
│   ├── LullabWidgetBundle.swift
│   └── LullabLiveActivity.swift
├── Resources/
│   ├── Assets.xcassets
│   ├── Lullab.xcdatamodeld
│   └── Info.plist
└── Extensions/
    ├── Color+Hex.swift
    ├── Date+Formatting.swift
    └── View+Modifiers.swift
```

## Implementation Flow

1. **Create Xcode project** with SwiftUI lifecycle, Core Data, CloudKit, and WidgetKit targets
2. **Implement Design System** — Colors, Typography, reusable components (dark-first)
3. **Set up Core Data stack** — Event and Baby entities with NSPersistentCloudKitContainer
4. **Build Onboarding** — Baby name + birthdate setup (10 seconds)
5. **Build Home View** — 4-tile quick log grid with baby header and last-event bar
6. **Implement Feed Tracking** — 1-tap log + detail sheet (breast/bottle/solid)
7. **Implement Sleep Tracking** — 1-tap log + Live Activity timer
8. **Implement Diaper Tracking** — 1-tap log + type picker (wet/dirty/mixed)
9. **Implement Growth Tracking** — Log entry + WHO percentile chart (Swift Charts)
10. **Build Timeline View** — Chronological event list with swipe-to-edit/delete
11. **Implement CloudKit Sync** — Private database, custom zone, change tokens
12. **Implement Live Activity** — Sleep/feed timer on lock screen and Dynamic Island
13. **Implement WidgetKit** — Home screen and lock screen glanceable widgets
14. **Build Settings** — Baby profile, doctor report, premium paywall, about
15. **Implement StoreKit 2** — Subscription management, premium feature gating
16. **Implement Doctor Report** — PDF generation with feeding/sleep/diaper summaries
17. **Add Contact Support** — Email-based support with device info
18. **Test on simulators** — iPhone and iPad builds
19. **Push to GitHub** — Repository creation and code push

## UI/UX Design Specifications

### Design Philosophy: Dark-First + One-Handed + Calm

Three core principles:
1. **Dark-First**: Dark mode is not an inversion — it is the default experience designed from scratch
2. **One-Handed**: All primary actions within thumb-reach zone (bottom 60% of screen)
3. **Calm**: No red warnings, no popup interruptions, no social noise, no guilt

### Color System

**Dark Theme (Default/Primary)**:
| Token | Hex | Usage |
|-------|-----|-------|
| Background | #000000 | OLED pure black — saves battery, gentle on eyes |
| Surface | #1C1C1E | Card/tile background |
| Surface Elevated | #2C2C2E | Buttons, input fields, elevated cards |
| Text Primary | #FFFFFF | Main text |
| Text Secondary | #8E8E93 | Timestamps, labels |
| Separator | #38383A | Divider lines |

**Accent Colors**:
| Token | Hex | Usage |
|-------|-----|-------|
| Feed | #FF9F0A | Warm orange — warmth, nourishment |
| Sleep | #0A84FF | Soft blue — calm, nighttime |
| Diaper | #30D158 | Fresh green — natural, healthy |
| Growth | #BF5AF2 | Soft purple — growth, change |
| Accent/CTA | #FFD60A | Gold — call-to-action, emphasis |

**Light Theme (Follows System)**:
| Token | Hex | Usage |
|-------|-----|-------|
| Background | #F2F2F7 | Standard iOS light background |
| Surface | #FFFFFF | Card background |
| Surface Elevated | #F2F2F7 | Elevated elements |
| Text Primary | #000000 | Main text |
| Text Secondary | #636366 | Secondary text |

### Typography

| Style | Size | Weight | Design |
|-------|------|--------|--------|
| Large Title | 34pt | Bold | Rounded |
| Title 1 | 28pt | Bold | Rounded |
| Title 2 | 22pt | Semibold | Rounded |
| Title 3 | 20pt | Semibold | Rounded |
| Body | 17pt | Regular | Rounded |
| Caption | 12pt | Regular | Rounded |
| Timer Display | 48pt | Thin | Monospaced |

### Layout Rules

- **Quick-log tiles**: 2x2 grid, equal width, minimum 120pt height
- **Touch targets**: Minimum 44x44pt, quick-log tiles 80pt+ height
- **Padding**: 16pt horizontal, 12pt between tiles
- **Tab bar**: 3 tabs — Home, Timeline, Settings
- **Detail views**: Presented as sheets (not push navigation)
- **Timeline**: Scrollable list with 56pt row height

### Animations

- **Quick-log tap**: Spring animation (response: 0.3, dampingFraction: 0.7)
- **Sheet presentation**: iOS default sheet animation
- **Timer update**: Implicit animation, 1-second interval
- **Swipe actions**: iOS default swipe animation
- **No aggressive animations**: Calm, subtle, non-distracting

### Interaction Specifications

| Interaction | Specification | Rationale |
|-------------|--------------|-----------|
| Quick log | 1-tap to start, auto-save | 3 AM one-handed use |
| Edit entry | Swipe left → Edit/Delete | iOS-native pattern |
| Time display | "14:30 (1h 23m ago)" | Both absolute and relative |
| Timer | Live Activity on lock screen | Persists when leaving app |
| Night mode | Always dark, follows system | OLED battery save + eye comfort |
| Notifications | Feed/diaper overdue only | Non-intrusive, essential only |
| Font | Rounded design + Dynamic Type | Warmth + accessibility |
| Touch area | Minimum 44x44pt | Apple HIG standard |
| Haptics | Light impact on quick-log tap | Tactile confirmation |

### App Icon

- **Background**: #0A0A1A (deep night blue-black)
- **Crescent moon**: #FFD60A (gold)
- **Music note**: #FFD60A (gold, inside crescent)
- **Style**: Flat + subtle gradient, no text
- **Concept**: Moon + note = lullaby = Lullab

### 2026 UI Trend Alignment

| Trend | Lullab Implementation |
|-------|----------------------|
| Dark-first design | Core design philosophy |
| OLED pure black | #000000 background |
| Bottom sheet architecture | Detail views as sheets |
| Gesture navigation + haptics | Swipe-to-edit + UIImpactFeedbackGenerator |
| Live Activity | Sleep/feed timer on lock screen |
| Dynamic Island | Timer adapts to Dynamic Island |
| WidgetKit interaction | Home/lock screen widgets |
| No-account design | iCloud auto-sync, no sign-up |
| Privacy-first | No third-party SDKs, local-first |
| Liquid Glass (iOS 26) | Future adoption for translucent surfaces |

## Code Generation Rules

- One feature per module, high cohesion, low coupling
- Semantic naming, clear file structure
- Never add comments in code unless asked
- Apple native first: prioritize SwiftUI, StoreKit 2, CloudKit, ActivityKit
- Modern Swift concurrency: async/await, no completion handlers
- Core Data local-first: always save locally before sync
- MVVM architecture: View → ViewModel → Service → Core Data
- All errors handled gracefully with toast notifications, never crash
- Dynamic Type + VoiceOver support on all views
- Minimum touch target 44x44pt on all interactive elements

## Build & Deployment Checklist

- [ ] Xcode project created with SwiftUI lifecycle
- [ ] Core Data model configured with NSPersistentCloudKitContainer
- [ ] CloudKit container identifier set to iCloud.com.zzoutuo.Lullab
- [ ] App Groups configured for WidgetKit data sharing
- [ ] ActivityKit capability enabled for Live Activities
- [ ] StoreKit 2 configuration file created for subscription testing
- [ ] App icon generated and added to asset catalog
- [ ] Launch screen configured (dark background, Lullab logo)
- [ ] Privacy policy URL added to Info.plist and App Store Connect
- [ ] Support URL added to Info.plist and App Store Connect
- [ ] Age rating set (4+ — no violence, no user-generated content)
- [ ] App Store category: Medical / Health & Fitness
- [ ] Restore Purchases button visible in Settings and Paywall
- [ ] No placeholder screens or "coming soon" features
- [ ] Build tested on iPhone simulator (iOS 17+)
- [ ] Build tested on iPad simulator
- [ ] Code pushed to GitHub repository

## Reference Projects

1. **Bloomly** — [github.com/vpavlov-me/Bloomly](https://github.com/vpavlov-me/Bloomly) (MIT, Swift 5.10 + SwiftUI + CloudKit, best starting point)
2. **Maby** — [github.com/sleepyfran/maby](https://github.com/sleepyfran/maby) (SwiftUI + watchOS, reference for watch design)
3. **BabyBuddy** — [github.com/babybuddy/babybuddy](https://github.com/babybuddy/babybuddy) (BSD-2, Django, reference for data model design)
