import Foundation
import CoreData

@objc(CDEvent)
public class CDEvent: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID?
    @NSManaged public var type: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var metadata: Data?
    @NSManaged public var notes: String?
}

extension CDEvent {
    static func fetchRequest() -> NSFetchRequest<CDEvent> {
        NSFetchRequest<CDEvent>(entityName: "CDEvent")
    }
}
