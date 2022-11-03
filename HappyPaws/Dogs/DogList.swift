//
//  DogList.swift
//  HappyPaws
//
//  Created by Greg Pearman on 11/2/22.
//

import SwiftUI

struct DogList: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  var dogs: [Dog]
  
  var body: some View {
    let dogsSorted = dogs.sorted(by: <)
    List {
      ForEach(dogsSorted) { dog in
        NavigationLink(destination: DogDetailView(dog: dog)) {
          DogListRow(dog: dog)
        }
      }
      .onDelete(perform: deleteDogs)
    }
    .navigationBarTitle("All Dogs")
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        EditButton()
      }
      ToolbarItem {
        Button(action: addDog) {
          Label("Add Dog", systemImage: "plus")
        }
      }
    }
  }
  
  private func addDog() {
    withAnimation {
      let newDog = Canine(context: viewContext)
      newDog.id = UUID()
      newDog.name = "Haps New Dog"
      
      do {
        try viewContext.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
  
  private func deleteDogs(offsets: IndexSet) {
//    var canines = [Canine]()
//    
//    offsets.map { dogs[$0] }.forEach {
//      let canine = dogs[$0].createCanine(from: dogs[$0], context: viewContext)
//      canines.append(canine)
//    }
//    
//    withAnimation {
//      offsets.map { dogs[$0] }.forEach(viewContext.delete)
//      
//      do {
//        try viewContext.save()
//      } catch {
//        // Replace this implementation with code to handle the error appropriately.
//        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        let nsError = error as NSError
//        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//      }
//    }
  }

}

struct DogList_Previews: PreviewProvider {
  static var previews: some View {
    DogList(dogs: PetStore.sample.dogs)
  }
}
