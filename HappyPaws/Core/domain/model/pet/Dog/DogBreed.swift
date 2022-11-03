//
//  DogBreed.swift
//  HappyPaws
//
//  Created by Greg Pearman on 11/1/22.
//

import Foundation

struct DogBreed: Identifiable, Comparable, Codable {
  let id: Int
  let name: String
  let temperament: String?
  let lifeSpan: String?
  let origin: String?
  let countryCode: String?
  let breedGroup: String?
  let breedFor: String?

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

  static func == (lhs: DogBreed, rhs: DogBreed) -> Bool {
    lhs.id == rhs.id
  }

  static func < (lhs: DogBreed, rhs: DogBreed) -> Bool {
    lhs.name < rhs.name
  }
}
