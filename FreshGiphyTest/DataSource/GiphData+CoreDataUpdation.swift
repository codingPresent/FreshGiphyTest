//
//  GiphData+CoreDataUpdation.swift
//  FreshGiphyTest
//
//  Created by Naveen Kumawat on 08/06/22.
//

import CoreData

extension GiphData {
    convenience init(id: String, giphData: Data, context: NSManagedObjectContext) {
        self.init(context: context)
        update(with: id, giphData: giphData, context: context)
    }
    
    func update(with giphID: String, giphData: Data, context: NSManagedObjectContext) {
        id      = giphID
        data    = giphData
    }
    
}
