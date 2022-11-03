//
//  PetStore.swift
//  HappyPaws
//
//  Created by Greg Pearman on 10/31/22.
//

import Foundation

class PetStore {
  private(set) var dogs: [Dog] = []
  private(set) var dogBreeds: [DogBreed] = []
  
  static let shared = PetStore()
  
  private init() {
    Task {
      dogBreeds = try await PersistenceController.getDogBreeds()

      if dogBreeds.isEmpty {
        dogBreeds = try await DogAPI.getAllDogBreeds()
        try await PersistenceController.saveCanineBreeds(from: dogBreeds)
      }
      
      dogs = try await PersistenceController.getDogs()
      
      if dogs.isEmpty {
        dogs = PetStore.createSampleDogs()
        try await PersistenceController.saveCanines(from: dogs)
      }
    }
  }
  
  func add(dog: Dog) {
    dogs.append(dog)
  }

  func remove(dog: Dog) {
    guard let index = dogs.firstIndex(of: dog) else { return }
    dogs.remove(at: index)
  }
  
  func add(dogBreed: DogBreed) {
    dogBreeds.append(dogBreed)
  }

  func remove(dogBreed: DogBreed) {
    guard let index = dogBreeds.firstIndex(of: dogBreed) else { return }
    dogBreeds.remove(at: index)
  }
  
  func geDogBy(name: String) -> Dog? {
    let matchingDogs = dogs.filter({$0.name == name})
    guard let dog = matchingDogs.first else {
      return nil
    }
    
    return dog
  }
}


#if DEBUG
extension PetStore {
  static var sample: PetStore = {
    // Add pets to the pet store
    let dogs = PetStore.createSampleDogs()
    let store = PetStore.shared
    store.dogs = dogs
    
    return store
  }()
  
  static func createSampleDogs() -> [Dog] {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-mm-dd"
    
    // Create some dogs
    let pongo = Dog(name: "Pongo",
                    dateOfBirth: formatter.date(from: "2019-02-11") ?? Date(),
                    image: "pongo",
                    favoriteToy: "fluffy lambie")
    let purdy = Dog(name: "Purdy",
                    dateOfBirth: formatter.date(from: "2019-07-20") ?? Date(),
                    image: nil,
                    favoriteToy: "giraffe")
    let dipstick = Dog(name: "Dipstick",
                       dateOfBirth: formatter.date(from: "2021-12-25") ?? Date(),
                       image: "dipstick",
                       favoriteToy: "squeeky fire hydrant")
    let jewel = Dog(name: "Jewel",
                    dateOfBirth: formatter.date(from: "2021-12-25") ?? Date(),
                    image: "jewel",
                    favoriteToy: "fuzzy sheep")
    let dottie = Dog(name: "Dottie",
                     dateOfBirth: formatter.date(from: "2021-12-25") ?? Date(),
                     image: "dottie",
                     favoriteToy: nil)
    let bravo = Dog(name: "Bravo",
                    dateOfBirth: formatter.date(from: "2021-12-25") ?? Date(),
                    image: nil,
                    favoriteToy: nil)
    // Make a couple of the pets favorites
    pongo.isFavorite = true
    dipstick.isFavorite = true
    
    return [pongo, purdy, dipstick, jewel, dottie, bravo]
  }
}
#endif
