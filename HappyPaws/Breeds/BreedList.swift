//
//  BreedList.swift
//  HappyPaws
//
//  Created by Greg Pearman on 11/3/22.
//

import SwiftUI

struct BreedList: View {
  @Environment(\.managedObjectContext) private var viewContext

  var breeds: [DogBreed]

  var body: some View {
    let dogBreedsSorted = breeds.sorted(by: <)

    List {
      ForEach(dogBreedsSorted) { dogBreed in
        NavigationLink(destination: BreedDetailView(dogBreed: dogBreed)) {
          BreedListRow(dogBreed: dogBreed)
        }
      }
    }
    .navigationBarTitle("All Breeds")
  }
}

struct BreedList_Previews: PreviewProvider {
  static var previews: some View {
    BreedList(breeds: [DogBreed.sample()])
  }
}
