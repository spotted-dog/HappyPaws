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

  @State private var showSplash = true
  @State var isDisplayingError = false
  @State var lastErrorMessage = "" {
    didSet { isDisplayingError = true }
  }

  @State private var selectedTab = 1

  var body: some View {
    ZStack {
      TabView(selection: $selectedTab) {
        WelcomeView()
          .tabItem {
            Image(systemName: "hand.wave")
            Text("Welcome")
              .accessibilityIdentifier("WelcomeTab")
          }
          .tag(0)

        DogList(dogs: petStore.dogs)
          .tabItem {
            Image(systemName: "house.fill")
            Text("Dog House")
              .accessibilityIdentifier("DogHouseTab")
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
      .alert("Error", isPresented: $isDisplayingError, actions: {
        Button("Close", role: .cancel) { }
      }, message: {
        Text(lastErrorMessage)
      })

      SplashScreenView()
        .opacity(showSplash ? 1 : 0)
        .task {
          do {
            try await Task.sleep(seconds: 10.0)
            SplashScreenView.shouldAnimate = false
            withAnimation { self.showSplash = false }
          } catch {
            lastErrorMessage = error.localizedDescription
          }
        }
    }
  }
}

struct DogsView_Previews: PreviewProvider {
  static var previews: some View {
    DogsView(petStore: PetStore.sample)
      .environment(\.managedObjectContext,
                    PersistenceController.preview.container.viewContext)
    DogsView(petStore: PetStore.sample)
      .environment(\.managedObjectContext,
                    PersistenceController.preview.container.viewContext)
      .preferredColorScheme(.dark)
    DogsView(petStore: PetStore.sample)
      .environment(\.managedObjectContext,
                    PersistenceController.preview.container.viewContext)
      .previewInterfaceOrientation(.landscapeLeft)
    DogsView(petStore: PetStore.sample)
      .environment(\.managedObjectContext,
                    PersistenceController.preview.container.viewContext)
      .preferredColorScheme(.dark)
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
