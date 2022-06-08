//
//  FavViewModel.swift
//  FreshGiphyTest
//
//  Created by Naveen Kumawat on 08/06/22.
//
import SwiftUI
import Combine
import CoreData

class FavViewModel: ObservableObject {
    
    func saveGif(with id: String, url: String) {
        loadData(id: id, urlString: url) { data, response, error in
            if let giphData = data{
                self.saveGiphsData(id: id, data: giphData)
            }
        }
    }
    
    private func saveGiphsData(id: String, data: Data) {
        let context = PersistenceController.shared.container.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.performAndWait {
            do {
                if let exisitingGiph = try self.fetchGiph(with: id, in: context) {
                    exisitingGiph.update(with: id, giphData: data, context: context)
                    do{
                        try exisitingGiph.managedObjectContext?.save()
                    }catch let error{
                        print("exisitingGiph: \(error)")
                    }
                }else {
                    let newGiph = GiphData(id: id, giphData: data, context: context)
                    do{
                        try newGiph.managedObjectContext?.save()
                    }catch let error{
                        print("newGiph: \(error)")
                    }
                }
                
                try context.save()
            }
            catch let error {
                print("Function: \(#function), line: \(#line) - Issue with saving context: \(error)")
                context.rollback()
            }
        }
    }
    
    func flagFav(with id: String) -> Bool {
        let context = PersistenceController.shared.container.viewContext
        do {
            if let exisitingGiph = try self.fetchGiph(with: id, in: context) {
                return true
            }else{
                return false
            }
        }catch let error {
            print("Function: \(#function), line: \(#line) - Issue with saving context: \(error)")
            return false
        }
    }
    
    private func fetchGiph(with id: String, in context: NSManagedObjectContext) throws -> GiphData? {
        let fetchRequest: NSFetchRequest<GiphData> = GiphData.fetchRequest()
        let p = NSPredicate(format: "id == %@", id)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [p])
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        return try context.fetch(fetchRequest).first
    }
    
    func removeGif(of id: String) {
        print("Deleting id: \(id)")
        let context = PersistenceController.shared.container.newBackgroundContext()
        let fetchRequest: NSFetchRequest<GiphData> = GiphData.fetchRequest()
        let p = NSPredicate(format: "id == %@", id)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [p])
        fetchRequest.predicate = predicate

        do {
            let objects = try context.fetch(fetchRequest)
            print("Deleting objects: \(objects.count)")
            for object in objects {
                context.delete(object)
            }
            try context.save()
        } catch let error {
            print("Function: \(#function), line: \(#line) - Issue with saving context: \(error)")
        }
    }
    
    private func loadData(id: String, urlString: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: urlString) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            completionHandler(data,response,error)
        }
        task.resume()
    }
}


