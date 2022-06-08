//
//  GiphData+CoreDataProperties.swift
//  FreshGiphyTest
//
//  Created by Naveen Kumawat on 08/06/22.
//
//

import Foundation
import CoreData


extension GiphData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GiphData> {
        return NSFetchRequest<GiphData>(entityName: "GiphData")
    }

    @NSManaged public var data: Data?
    @NSManaged public var id: String?

}

extension GiphData : Identifiable {

}
