//
//  Dog.swift
//  HappyPaws
//
//  Created by Greg Pearman on 11/1/22.
//

import Foundation

class Dog: Identifiable, Comparable, ObservableObject {
  var id = UUID()
  let name: String
  let dateOfBirth: Date
  var favoriteToy: String?
  var image: String?
  @Published var isFavorite: Bool = false
  
  init(name: String, dateOfBirth: Date) {
    self.name = name
    self.dateOfBirth = dateOfBirth
  }
  
  convenience init(name: String, dateOfBirth: Date, image: String?) {
    self.init(name: name, dateOfBirth: dateOfBirth)
    self.image = image
  }
  
  convenience init(name: String, dateOfBirth: Date, favoriteToy: String?) {
    self.init(name: name, dateOfBirth: dateOfBirth)
    self.favoriteToy = favoriteToy
  }
  
  convenience init(name: String, dateOfBirth: Date, image: String?, favoriteToy: String?) {
    self.init(name: name, dateOfBirth: dateOfBirth)
    self.image = image
    self.favoriteToy = favoriteToy
  }
  
  convenience init(name: String, dateOfBirth: Date, image: String?, favoriteToy: String?, isFavorite: Bool) {
    self.init(name: name, dateOfBirth: dateOfBirth, image: image, favoriteToy: favoriteToy)
    self.isFavorite = isFavorite
  }
  
  static func == (lhs: Dog, rhs: Dog) -> Bool {
    lhs.id == rhs.id
  }
  
  static func < (lhs: Dog, rhs: Dog) -> Bool {
    lhs.name < rhs.name
  }
  
  func getDateOfBirthString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-mm-dd"
    
    return formatter.string(from: self.dateOfBirth)
  }
}
