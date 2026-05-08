# Pricing Configuration

## Monetization Model: Subscription (IAP)

## Subscription Group
- **Group Name**: Lullab Premium
- **Group ID**: 21578649

## Subscription Tiers

### 1. Monthly Subscription
- **Reference Name**: Lullab Monthly Premium
- **Product ID**: `com.zzoutuo.Lullab.monthly`
- **Price**: $2.99 per month
- **Display Name**: Lullab Premium Monthly
- **Description**: Unlock unlimited history, charts & reports
- **Localization**: English (US)

### 2. Yearly Subscription
- **Reference Name**: Lullab Yearly Premium
- **Product ID**: `com.zzoutuo.Lullab.yearly`
- **Price**: $19.99 per year (44% savings vs monthly)
- **Display Name**: Lullab Premium Yearly
- **Description**: Best value — save 44% annually
- **Localization**: English (US)

## Free Tier Features (Always Free)
- Feed/Sleep/Diaper/Growth 1-tap logging
- 7-day event history
- CloudKit sync (both parents)
- Live Activity sleep/feed timer
- WidgetKit home/lock screen widgets
- Dark-first design
- No ads ever

## Premium Features (Subscription Required)
- Unlimited event history
- WHO growth percentile charts
- PDF doctor visit report generation
- Trend analysis and weekly summaries
- CSV data export
- Custom reminders

## Free Trial
- **Duration**: 7 days
- **Type**: Free trial (auto-converts to paid monthly)
- **Applies to**: Monthly subscription only

## Pricing Strategy Phases

| Phase | Period | Free Tier | Premium |
|-------|--------|-----------|---------|
| Launch | Month 1-3 | Full features + Premium $2.99/mo | User acquisition + word of mouth |
| Growth | Month 4-6 | 7-day history limit + Premium unchanged | Drive conversion |
| Mature | Month 7+ | 7-day history + Premium $2.99/mo or $19.99/yr | Stable revenue |

## Policy Pages Required
- Support Page: YES (must include subscription management info)
- Privacy Policy: YES
- Terms of Use: YES (REQUIRED for subscription apps)

## Apple IAP Compliance Checklist
- [x] Auto-renewal terms included in Terms
- [x] Cancellation instructions included
- [x] Pricing clearly stated
- [x] Free trial terms included (7-day for monthly)
- [x] Restore purchases functionality implemented
- [x] No dark patterns in paywall UI
- [x] Premium features clearly listed

## StoreKit Configuration
- **Configuration File**: Lullab.storekit
- **Testing**: Xcode StoreKit Testing in Simulator
- **Sandbox**: Test with sandbox Apple ID before submission

## Revenue Projections

| Scenario | MAU | Conversion Rate | Monthly Revenue | Annual Revenue |
|----------|-----|----------------|-----------------|----------------|
| Conservative | 5,000 | 3% | $449 | $5,384 |
| Moderate | 20,000 | 5% | $2,993 | $35,916 |
| Optimistic | 100,000 | 8% | $23,944 | $287,328 |

*Calculation: Monthly Revenue = MAU x Conversion Rate x $2.99 (assuming monthly dominant)*
