import Foundation

enum EventType: String, Codable, CaseIterable {
    case feed
    case sleep
    case diaper
    case growth

    var displayName: String {
        switch self {
        case .feed: "Feed"
        case .sleep: "Sleep"
        case .diaper: "Diaper"
        case .growth: "Growth"
        }
    }

    var icon: String {
        switch self {
        case .feed: "drop.fill"
        case .sleep: "moon.fill"
        case .diaper: "circle.fill"
        case .growth: "chart.line.uptrend.xyaxis"
        }
    }

    var color: String {
        switch self {
        case .feed: "FF9F0A"
        case .sleep: "0A84FF"
        case .diaper: "30D158"
        case .growth: "BF5AF2"
        }
    }
}

enum FeedType: String, Codable, CaseIterable {
    case breast
    case bottle
    case solid

    var displayName: String {
        switch self {
        case .breast: "Breast"
        case .bottle: "Bottle"
        case .solid: "Solid"
        }
    }

    var icon: String {
        switch self {
        case .breast: "heart.fill"
        case .bottle: "drop.fill"
        case .solid: "fork.knife"
        }
    }
}

enum BreastSide: String, Codable, CaseIterable {
    case left
    case right

    var displayName: String {
        switch self {
        case .left: "Left"
        case .right: "Right"
        }
    }
}

struct FeedMetadata: Codable {
    let feedType: FeedType
    let breastSide: BreastSide?
    let duration: TimeInterval?
    let volume: Double?
    let unit: String
    let notes: String?

    init(feedType: FeedType, breastSide: BreastSide? = nil, duration: TimeInterval? = nil, volume: Double? = nil, unit: String = "ml", notes: String? = nil) {
        self.feedType = feedType
        self.breastSide = breastSide
        self.duration = duration
        self.volume = volume
        self.unit = unit
        self.notes = notes
    }
}

struct SleepMetadata: Codable {
    let duration: TimeInterval?
    let quality: SleepQuality?
    let notes: String?

    init(duration: TimeInterval? = nil, quality: SleepQuality? = nil, notes: String? = nil) {
        self.duration = duration
        self.quality = quality
        self.notes = notes
    }
}

enum SleepQuality: String, Codable, CaseIterable {
    case restless
    case normal
    case deep

    var displayName: String {
        switch self {
        case .restless: "Restless"
        case .normal: "Normal"
        case .deep: "Deep"
        }
    }

    var icon: String {
        switch self {
        case .restless: "wind"
        case .normal: "moon.fill"
        case .deep: "moon.zzz.fill"
        }
    }
}

enum DiaperType: String, Codable, CaseIterable {
    case wet
    case dirty
    case mixed

    var displayName: String {
        switch self {
        case .wet: "Wet"
        case .dirty: "Dirty"
        case .mixed: "Mixed"
        }
    }

    var icon: String {
        switch self {
        case .wet: "drop.fill"
        case .dirty: "circle.fill"
        case .mixed: "circle.grid.2x2.fill"
        }
    }
}

struct DiaperMetadata: Codable {
    let diaperType: DiaperType
    let color: DiaperColor?
    let notes: String?

    init(diaperType: DiaperType, color: DiaperColor? = nil, notes: String? = nil) {
        self.diaperType = diaperType
        self.color = color
        self.notes = notes
    }
}

enum DiaperColor: String, Codable, CaseIterable {
    case yellow
    case green
    case brown
    case black
    case red

    var displayName: String {
        switch self {
        case .yellow: "Yellow"
        case .green: "Green"
        case .brown: "Brown"
        case .black: "Black"
        case .red: "Red"
        }
    }
}

struct GrowthMetadata: Codable {
    let weight: Double?
    let weightUnit: String
    let height: Double?
    let heightUnit: String
    let headCircumference: Double?
    let headUnit: String
    let notes: String?

    init(weight: Double? = nil, weightUnit: String = "kg", height: Double? = nil, heightUnit: String = "cm", headCircumference: Double? = nil, headUnit: String = "cm", notes: String? = nil) {
        self.weight = weight
        self.weightUnit = weightUnit
        self.height = height
        self.heightUnit = heightUnit
        self.headCircumference = headCircumference
        self.headUnit = headUnit
        self.notes = notes
    }
}

struct EventItem: Identifiable {
    let id: UUID
    let type: EventType
    let timestamp: Date
    let metadata: Data?
    let notes: String?

    var decodedFeed: FeedMetadata? {
        guard type == .feed, let metadata else { return nil }
        return try? JSONDecoder().decode(FeedMetadata.self, from: metadata)
    }

    var decodedSleep: SleepMetadata? {
        guard type == .sleep, let metadata else { return nil }
        return try? JSONDecoder().decode(SleepMetadata.self, from: metadata)
    }

    var decodedDiaper: DiaperMetadata? {
        guard type == .diaper, let metadata else { return nil }
        return try? JSONDecoder().decode(DiaperMetadata.self, from: metadata)
    }

    var decodedGrowth: GrowthMetadata? {
        guard type == .growth, let metadata else { return nil }
        return try? JSONDecoder().decode(GrowthMetadata.self, from: metadata)
    }
}

struct BabyProfile {
    let id: UUID
    let name: String
    let birthdate: Date
    let avatarData: Data?

    var ageString: String {
        birthdate.ageString
    }
}
