import Foundation
import CoreData
import UIKit

public class CoreDataManager {

public static let shared = CoreDataManager()

let identifier: String  = "tate.Spotify"       //Framework bundle ID
let model: String       = "Model"                      //Model name


lazy var persistentContainer: NSPersistentContainer = {

let messageKitBundle = Bundle(identifier: self.identifier)
let modelURL = messageKitBundle!.url(forResource: self.model, withExtension: "momd")!

let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)


let container = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel!)
container.loadPersistentStores { (storeDescription, error) in

if let err = error{
fatalError("❌ Loading of store failed:\(err)")
}
}

return container
}()
   
    public func fetchIDS() -> [String] {
    let context = persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<ArtistE>(entityName: "ArtistE")

 
var versions = [String]()
    do{
        
    let fetchedData = try context.fetch(fetchRequest)
      
        if fetchedData.count > 0 {
            
       
        for index in 0...fetchedData.count  - 1 {
            
            versions.append(fetchedData[index].id ?? "")
            
        }
            
        }
        


    try context.save()

    }catch let fetchErr {

    print("❌ Failed to fetch Person:",fetchErr)
        
    }
    return versions

    }
    public func appendID(id: String){

    let context = persistentContainer.viewContext
    let Store = NSEntityDescription.insertNewObject(forEntityName: "ArtistE", into: context) as! ArtistE
            
        
        Store.id = id
        
        
    do {
    try context.save()


    } catch let error {
    print("❌ Failed to create Person: \(error.localizedDescription)")
    }
    }

        public func deleteID(id: String){
    
                      let context = persistentContainer.viewContext
    
               let fetchRequest = NSFetchRequest<ArtistE>(entityName: "ArtistE")
    
               let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
    
                 do{
                            var array = try context.fetch(fetchRequest)
             
                     for object in array {
                         if object.id! == id {
                             context.delete(object)
                         }
                     }
                     try context.save()
    
                        }catch let fetchErr {
                            print("❌ Failed to fetch Person:",fetchErr)
                        }
    
           }
    public func delete_All(){

    let context = persistentContainer.viewContext

    let fetchRequest = NSFetchRequest<ArtistE>(entityName: "ArtistE")

    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
    do {
    try context.execute(batchDeleteRequest)

    } catch {
    // Error Handling
    }
        
    }
}
