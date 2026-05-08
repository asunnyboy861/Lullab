# Capabilities Configuration

## Analysis
Based on operation guide analysis, the following capabilities are required:

| Keyword Found | Capability Required |
|---------------|-------------------|
| "CloudKit同步" / "sync" / "iCloud" | iCloud (CloudKit) |
| "双父母同步" / "share" / "共享" | iCloud + CloudKit Private DB |
| "Live Activity" / "后台计时" | Background Modes (Live Activities) |
| "WidgetKit" / "小组件" | WidgetKit Extension |
| "StoreKit 2" / "订阅" / "premium" | In-App Purchase |
| "通知" / "提醒" | Push Notifications |
| "PDF报告" / "分享" | No special capability needed |

## Auto-Configured Capabilities

| Capability | Status | Method |
|------------|--------|--------|
| In-App Purchase | Configured in code | StoreKit 2 (no entitlement needed) |
| Push Notifications | Configured in code | UNUserNotificationCenter |
| Background Modes | Configured in code | ActivityKit (Live Activities) |

## Manual Configuration Required

| Capability | Status | Steps |
|------------|--------|-------|
| iCloud (CloudKit) | Pending | 1. Open Xcode > Signing & Capabilities > + Capability > iCloud 2. Check CloudKit 3. Add container: iCloud.com.zzoutuo.Lullab 4. Set container scope to Private |
| App Groups | Pending | 1. Open Xcode > Signing & Capabilities > + Capability > App Groups 2. Add group: group.com.zzoutuo.Lullab 3. Also add to Widget extension target |
| Widget Extension | Pending | 1. File > New > Target > Widget Extension 2. Name: LullabWidget 3. Add App Groups capability to widget target |

## No Configuration Needed

- HealthKit: Not required (app is wellness tracker, not medical device)
- Camera/Photo Library: Not required (baby photo is optional, stored locally)
- Location Services: Not required
- Sign in with Apple: Not required (uses iCloud identity)
- Siri: Not required
- Apple Watch: Future phase, not in MVP

## Verification
- Build succeeded after configuration: Pending (will verify in build step)
- All entitlements correct: Pending
