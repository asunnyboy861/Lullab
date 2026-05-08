import Foundation
import CoreData

@objc(CDBaby)
public class CDBaby: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var birthdate: Date?
    @NSManaged public var avatarData: Data?
}

extension CDBaby {
    static func fetchRequest() -> NSFetchRequest<CDBaby> {
        NSFetchRequest<CDBaby>(entityName: "CDBaby")
    }
}
