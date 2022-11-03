//
//  DogBreed.swift
//  HappyPaws
//
//  Created by Greg Pearman on 11/1/22.
//

import Foundation
import CoreData

class DogBreed: Identifiable, Comparable, Codable, ObservableObject {
  var id: Int
  var name: String
  var temperament: String?
  var lifeSpan: String?
  var origin: String?
  var countryCode: String?
  var breedGroup: String?
  var breedFor: String?

  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case temperament
    case lifeSpan = "life_span"
    case origin
    case countryCode = "country_code"
    case breedGroup = "breed_group"
    case breedFor = "bread_for"
  }

  init(id: Int, name: String) {
    self.id = id
    self.name = name
  }

  convenience init(id: Int,
                   name: String,
                   temperament: String?,
                   lifeSpan: String?,
                   origin: String?,
                   countryCode: String?,
                   breedGroup: String?,
                   breedFor: String?) {
    self.init(id: id, name: name)
    self.temperament = temperament
    self.lifeSpan = lifeSpan
    self.origin = origin
    self.countryCode = countryCode
    self.breedGroup = breedGroup
    self.breedFor = breedFor
  }

  static func == (lhs: DogBreed, rhs: DogBreed) -> Bool {
    lhs.id == rhs.id
  }

  static func < (lhs: DogBreed, rhs: DogBreed) -> Bool {
    lhs.name < rhs.name
  }

  static func sample() -> DogBreed {
    let breed =
    DogBreed(id: 1,
             name: "Cattle Dog",
             temperament: "Outgoing, Friendly, Energetic, Playful, Sensitive, Intelligent, Active",
             lifeSpan: "15 - 20 years",
             origin: "Ute Reservation",
             countryCode: "US",
             breedGroup: "Non-Sporting",
             breedFor: "Cattle dog - work the ranch with the cowboy")

    return breed
  }

  func createCanineBreed(context: NSManagedObjectContext) -> CanineBreed {
    let canineBreed = CanineBreed(context: context)
    canineBreed.id = Int64(self.id)
    canineBreed.name = self.name
    canineBreed.temperament = self.temperament
    canineBreed.lifeSpan = self.lifeSpan
    canineBreed.origin = self.origin
    canineBreed.countryCode = self.countryCode
    canineBreed.breedGroup = self.breedGroup
    canineBreed.breedFor = self.breedFor

    return canineBreed
  }
}
