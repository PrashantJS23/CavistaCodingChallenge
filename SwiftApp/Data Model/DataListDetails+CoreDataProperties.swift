//
//  DataListDetails+CoreDataProperties.swift
//  
//
//  Created by WYH_MAC001 on 05/09/20.
//
//

import Foundation
import CoreData


extension DataListDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataListDetails> {
        return NSFetchRequest<DataListDetails>(entityName: "DataListDetails")
    }

    @NSManaged public var id: String?
    @NSManaged public var type: String?
    @NSManaged public var date: String?
    @NSManaged public var desc: String?

}
