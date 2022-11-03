//
//  HappyPawsApp.swift
//  HappyPaws
//
//  Created by Greg Pearman on 10/29/22.
//

import SwiftUI

@main
struct HappyPawsApp: App {
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    WindowGroup {
      DogsView(petsStore: PetStore.sample)
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
