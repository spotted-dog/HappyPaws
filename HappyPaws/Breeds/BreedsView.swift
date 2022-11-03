//
//  ContentView.swift
//  HappyPaws
//
//  Created by Greg Pearman on 10/29/22.
//

import SwiftUI
import CoreData

struct BreedsView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \CanineBreed.name, ascending: true)],
    animation: .default)
  private var dogBreeds: FetchedResults<CanineBreed>

  var body: some View {
    NavigationView {
      List {
        ForEach(dogBreeds) { dogBreed in
          NavigationLink {
            Text("\(dogBreed.name!)")
          } label: {
            Text(dogBreed.name!)
              .font(.system(.headline))
              .foregroundColor(.gray)
          }
        }
        .onDelete(perform: deleteBreeds)
      }
      .navigationBarTitle("All Breeds")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
        ToolbarItem {
          Button(action: addBreed) {
            Label("Add Breed", systemImage: "plus")
          }
        }
      }
      Text("Select a Breed")
    }
  }

  private func addBreed() {
    withAnimation {
      let newDogBreed = CanineBreed(context: viewContext)
      newDogBreed.id = 101
      newDogBreed.name = "Haps New Breed"

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
    }
  }

  private func deleteBreeds(offsets: IndexSet) {
    withAnimation {
      offsets.map { dogBreeds[$0] }.forEach(viewContext.delete)

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
    }
  }
}

private let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .medium
  return formatter
}()

struct BreedsView_Previews: PreviewProvider {
  static var previews: some View {
    BreedsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
