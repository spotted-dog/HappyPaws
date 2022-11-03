//
//  DogsView.swift
//  HappyPaws
//
//  Created by Greg Pearman on 10/30/22.
//

import SwiftUI
import CoreData

struct DogsView: View {
  @Environment(\.managedObjectContext) private var viewContext

  var petStore: PetStore

  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Canine.name, ascending: true)],
    animation: .default)
  private var dogs: FetchedResults<Canine>

  @State private var selectedTab = 1

  var body: some View {
    TabView(selection: $selectedTab) {
      WelcomeView()
        .tabItem {
          Image(systemName: "hand.wave")
          Text("Welcome")
            .accessibilityIdentifier("WelcomeTab")
        }
        .tag(0)

      NavigationView {
        DogList(dogs: petStore.dogs)
        Text("Select a Dog")
      }
      .tabItem {
        Image(systemName: "house.fill")
        Text("Home")
          .accessibilityIdentifier("HomeTab")

      }
      .tag(1)

      BreedsView(breeds: petStore.dogBreeds)
        .tabItem {
          Image(systemName: "pawprint.fill")
          Text("Breeds")
            .accessibilityIdentifier("BreedsTab")

        }
        .tag(2)
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
        // fatalError() causes the application to generate a crash log and terminate.
        // You should not use this function in a shipping application, although it
        // may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }

  private func deleteDogs(offsets: IndexSet) {
    withAnimation {
      offsets.map { dogs[$0] }.forEach(viewContext.delete)

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

struct DogsView_Previews: PreviewProvider {
  static var previews: some View {
    DogsView(petStore: PetStore.sample)
      .environment(\.managedObjectContext,
                    PersistenceController.preview.container.viewContext)
  }
}
