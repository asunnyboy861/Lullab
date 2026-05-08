import Foundation
import CoreData

final class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    let viewContext: NSManagedObjectContext

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Lullab")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("Failed to load Core Data stack")
        }

        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Core Data failed: \(error)")
            }
        }

        viewContext = container.viewContext
        viewContext.automaticallyMergesChangesFromParent = true
        viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    func save() {
        guard viewContext.hasChanges else { return }
        do {
            try viewContext.save()
        } catch {
            print("Save error: \(error)")
        }
    }

    func createEvent(type: EventType, timestamp: Date = Date(), metadata: Codable? = nil, notes: String? = nil) {
        let context = viewContext
        let event = CDEvent(context: context)
        event.id = UUID()
        event.type = type.rawValue
        event.timestamp = timestamp
        event.notes = notes
        if let metadata {
            event.metadata = try? JSONEncoder().encode(metadata)
        }
        save()
    }

    func fetchEvents(for date: Date = Date()) -> [CDEvent] {
        let request: NSFetchRequest<CDEvent> = CDEvent.fetchRequest()
        let start = date.startOfDay
        let end = Calendar.current.date(byAdding: .day, value: 1, to: start)!
        request.predicate = NSPredicate(format: "timestamp >= %@ AND timestamp < %@", start as NSDate, end as NSDate)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDEvent.timestamp, ascending: false)]
        return (try? viewContext.fetch(request)) ?? []
    }

    func fetchAllEvents(limit: Int = 100) -> [CDEvent] {
        let request: NSFetchRequest<CDEvent> = CDEvent.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDEvent.timestamp, ascending: false)]
        request.fetchLimit = limit
        return (try? viewContext.fetch(request)) ?? []
    }

    func deleteEvent(_ event: CDEvent) {
        viewContext.delete(event)
        save()
    }

    func fetchBaby() -> CDBaby? {
        let request: NSFetchRequest<CDBaby> = CDBaby.fetchRequest()
        request.fetchLimit = 1
        return (try? viewContext.fetch(request))?.first
    }

    func createBaby(name: String, birthdate: Date) {
        let baby = CDBaby(context: viewContext)
        baby.id = UUID()
        baby.name = name
        baby.birthdate = birthdate
        save()
    }

    func updateBaby(_ baby: CDBaby, name: String? = nil, birthdate: Date? = nil) {
        if let name { baby.name = name }
        if let birthdate { baby.birthdate = birthdate }
        save()
    }
}
