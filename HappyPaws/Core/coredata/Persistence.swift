//
//  Persistence.swift
//  HappyPaws
//
//  Created by Greg Pearman on 10/29/22.
//

import CoreData

struct PersistenceController {
  static let shared = PersistenceController()
  
  static var preview: PersistenceController = {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.container.viewContext
    
    var breedId: Int64 = 1
    for _ in 0..<10 {
      let newItem = DogBreed(context: viewContext)
      newItem.id = breedId
      newItem.breedFor = "Carriage dog - trot alongside carriages to protect the occupants from banditry or other interference"
      newItem.breedGroup = "Non-Sporting"
      newItem.countryCode = "GB"
      newItem.name = "Dalmatian - \(breedId)"
      newItem.lifeSpan = "10 - 13 years"
      newItem.origin = "London, England - UK"
      newItem.temperament = "Outgoing, Friendly, Energetic, Playful, Sensitive, Intelligent, Active"
      
      breedId += 1
    }
    
    for dogCounter in 1..<11 {
      let newDog = Dog(context: viewContext)
      newDog.id = UUID()
      newDog.name = "New Dog \(dogCounter)"
      newDog.dateOfBirth = Date()
      newDog.favoriteToy = "stuffed bear"
    }
    
    do {
      try viewContext.save()
    } catch {
      // Replace this implementation with code to handle the error appropriately.
      // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    return result
  }()
  
  let container: NSPersistentContainer
  
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "HappyPaws")
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        
        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    container.viewContext.automaticallyMergesChangesFromParent = true
  }
}
