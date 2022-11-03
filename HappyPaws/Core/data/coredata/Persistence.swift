//
//  Persistence.swift
//  HappyPaws
//
//  Created by Greg Pearman on 10/29/22.
//

import CoreData

struct PersistenceController {
  static let shared = PersistenceController()

  enum PersistentCoreDataError: Error {
    case batchInsertError
    case fetchError
    case saveError
  }

  static var preview: PersistenceController = {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.container.viewContext

    var breedId: Int64 = 1
    for _ in 0..<10 {
      let newItem = CanineBreed(context: viewContext)
      newItem.id = breedId
      newItem.breedFor =
        "Carriage dog - trot alongside carriages to protect the occupants from banditry or other interference"
      newItem.breedGroup = "Non-Sporting"
      newItem.countryCode = "GB"
      newItem.name = "Dalmatian - \(breedId)"
      newItem.lifeSpan = "10 - 13 years"
      newItem.origin = "London, England - UK"
      newItem.temperament = "Outgoing, Friendly, Energetic, Playful, Sensitive, Intelligent, Active"

      breedId += 1
    }

    for dogCounter in 1..<11 {
      let newDog = Canine(context: viewContext)
      newDog.id = UUID()
      newDog.name = "New Dog \(dogCounter)"
      newDog.dateOfBirth = Date()
      newDog.favoriteToy = "stuffed bear"
    }

    do {
      try viewContext.save()
    } catch {
      // Replace this implementation with code to handle the error appropriately.
      // fatalError() causes the application to generate a crash log and terminate.
      // You should not use this function in a shipping application, although it
      // may be useful during development.
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
    container.loadPersistentStores(completionHandler: { (_, error) in
      if let error = error as NSError? {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate.
        // You should not use this function in a shipping application, although it may
        // be useful during development.

        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection
         // when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    container.viewContext.automaticallyMergesChangesFromParent = true
  }

  private func newTaskContext() -> NSManagedObjectContext {
    let taskContext = container.newBackgroundContext()
    taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    return taskContext
  }

  static func getDogBreeds() async throws -> [DogBreed] {
    var dogBreeds = [DogBreed]()

    do {
      if let canineBreeds = try await PersistenceController.shared.fetchCanineBreeds() {
        for canineBreed in canineBreeds {
          let dogBreed = DogBreed(id: Int(canineBreed.id),
                                  name: canineBreed.name ?? "Unknown Breed",
                                  temperament: canineBreed.temperament,
                                  lifeSpan: canineBreed.lifeSpan,
                                  origin: canineBreed.origin,
                                  countryCode: canineBreed.countryCode,
                                  breedGroup: canineBreed.breedGroup,
                                  breedFor: canineBreed.breedFor)
          dogBreeds.append(dogBreed)
        }
      }
    } catch {
      print("error is \(error)")
      throw PersistentCoreDataError.fetchError
    }

    return dogBreeds
  }

  private func fetchCanineBreeds() async throws -> [CanineBreed]? {
    var canineBreeds: [CanineBreed]
    let taskContext = newTaskContext()
    taskContext.name = "fetchContext"
    taskContext.transactionAuthor = "fetchCanineBreeds"

    do {
      canineBreeds = try taskContext.performAndWait { () -> [CanineBreed] in
        let fetchRequest = createFetchAllBreedsRequest()
        return try container.viewContext.fetch(fetchRequest) as? [CanineBreed] ?? [CanineBreed]()
      }
    } catch let error as NSError {
      print("Fail: \(error.localizedDescription)")
      throw PersistentCoreDataError.fetchError
    } catch {
      throw PersistentCoreDataError.fetchError
    }

    return canineBreeds
  }

  private func createFetchAllBreedsRequest() -> NSFetchRequest<NSFetchRequestResult> {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CanineBreed.description())
    return fetchRequest
  }

  static func saveCanineBreeds(from dogBreeds: [DogBreed]) async throws {
    let context = PersistenceController.shared.container.viewContext
    for dogBreed in dogBreeds {
      let newCanineBreed = CanineBreed(context: context)
      newCanineBreed.id = Int64(dogBreed.id)
      newCanineBreed.breedFor = dogBreed.breedFor
      newCanineBreed.breedGroup = dogBreed.breedGroup
      newCanineBreed.countryCode = dogBreed.countryCode
      newCanineBreed.name = dogBreed.name
      newCanineBreed.lifeSpan = dogBreed.lifeSpan
      newCanineBreed.origin = dogBreed.origin
      newCanineBreed.temperament = dogBreed.temperament
    }

    do {
      try context.save()
    } catch {
      throw PersistentCoreDataError.saveError
    }
  }

  static func getDogs() async throws -> [Dog] {
    var dogs = [Dog]()

    do {
      if let canines = try await PersistenceController.shared.fetchCanines() {
        for canine in canines {
          let dog = Dog(name: canine.name ?? "Unknown Dog",
                        dateOfBirth: canine.dateOfBirth ?? Date(),
                        image: canine.image,
                        favoriteToy: canine.favoriteToy,
                        isFavorite: canine.isFavorite)
          dogs.append(dog)
        }
      }
    } catch {
      print("error is \(error)")
      throw PersistentCoreDataError.fetchError
    }

    return dogs
  }

  private func fetchCanines() async throws -> [Canine]? {
    var canines: [Canine]
    let taskContext = newTaskContext()
    taskContext.name = "fetchContext"
    taskContext.transactionAuthor = "fetchCanines"

    do {
      canines = try taskContext.performAndWait { () -> [Canine] in
        let fetchRequest = createFetchAllCaninesRequest()
        return try container.viewContext.fetch(fetchRequest) as? [Canine] ?? [Canine]()
      }
    } catch let error as NSError {
      print("Fail: \(error.localizedDescription)")
      throw PersistentCoreDataError.fetchError
    } catch {
      throw PersistentCoreDataError.fetchError
    }

    return canines
  }

  private func createFetchAllCaninesRequest() -> NSFetchRequest<NSFetchRequestResult> {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Canine.description())
    return fetchRequest
  }

  static func saveCanines(from dogs: [Dog]) async throws {
    let context = PersistenceController.shared.container.viewContext
    for dog in dogs {
      let newCanine = Canine(context: context)
      newCanine.id = dog.id
      newCanine.name = dog.name
      newCanine.dateOfBirth = dog.dateOfBirth
      newCanine.favoriteToy = dog.favoriteToy
      newCanine.isFavorite = dog.isFavorite
      newCanine.image = dog.image
    }

    do {
      try context.save()
    } catch {
      throw PersistentCoreDataError.saveError
    }
  }
}
