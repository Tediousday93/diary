//
//  DataAccessObject.swift
//  Diary
//
//  Created by Rowan, Harry on 2023/05/06.
//

import CoreData

protocol DataAccessObject: AnyObject, NSManagedObject {
    associatedtype FetchResult: NSFetchRequestResult
    associatedtype DTO: DataTransferObject
    
    static func fetchRequest() -> NSFetchRequest<FetchResult>?
    
    func updateValue(data: DTO)
    
    func setValues(from data: DTO)
}

extension DataAccessObject {
    static func fetchRequest() -> NSFetchRequest<Self>? {
        guard let entityName = Self.entity().name else { return nil }
        return NSFetchRequest<Self>(entityName: entityName)
    }
    
    static func object(entityName: String, context: NSManagedObjectContext) -> Self? {
        guard let entityDescription = NSEntityDescription.entity(
            forEntityName: entityName,
            in: context
        ) else { return nil }
        guard let object = NSManagedObject(entity: entityDescription, insertInto: context) as? Self else { return nil }
        
        return object
    }
}