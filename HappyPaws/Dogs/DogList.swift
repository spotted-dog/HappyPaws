//
//  DogList.swift
//  HappyPaws
//
//  Created by Greg Pearman on 11/2/22.
//

import SwiftUI

struct DogList: View {
  @Environment(\.managedObjectContext) private var viewContext
  @Environment(\.dismiss) var dismiss

  @State var addDog = false
  @State var addDogName = ""
  @State var addDogFavoriteToy = ""
  @State var addDogDateOfBirth = Date()

  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Canine.name, ascending: true)],
    animation: .default)
  private var canines: FetchedResults<Canine>

  @State var dogs: [Dog]

  var limitRange: ClosedRange<Date> {
    let twentyYearsAgo = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
    let today = Date()

    return twentyYearsAgo...today
  }

  var body: some View {
    let dogsSorted = dogs.sorted(by: <)

    NavigationView {
      List {
        ForEach(dogsSorted) { dog in
          NavigationLink(destination: DogDetailView(dog: dog)) {
            DogListRow(dog: dog)
          }
        }
      }
      .navigationBarTitle("All Dogs")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            self.addDog.toggle()
          }, label: {
            Image(systemName: "plus")
          })
        }
      }
    }
    .sheet(isPresented: $addDog) {
      VStack {
        HStack {
          Text("Name: ")
            .font(.system(.title))
            .fontWeight(.bold)
            .foregroundColor(.gray)
          TextField("Dogs Name", text: self.$addDogName)
            .font(.system(.title))
            .foregroundColor(.gray)
        }

        DatePicker("Date of Birth",
                   selection: self.$addDogDateOfBirth,
                   in: limitRange,
                   displayedComponents: [.date])
          .padding()

        HStack {
          Text("Favorite Toy: ")
            .font(.system(.title))
            .fontWeight(.bold)
            .foregroundColor(.gray)
          TextField("Dogs favorite toy", text: self.$addDogFavoriteToy)
            .font(.system(.title))
            .foregroundColor(.gray)
        }

        HStack {
          Button(action: {
            self.addDogAction()
            self.addDog.toggle()
            dismiss()
          }, label: {
            Text("Add")
              .font(.system(.title))
              .fontWeight(.bold)
          })
          .padding()

          Button(action: {
            self.addDog.toggle()
            dismiss()
          }, label: {
            Text("Cancel")
              .font(.system(.title))
              .fontWeight(.bold)
          })
          .padding()
        }
      }
    }
  }

  private func addDogAction() {
    withAnimation {
      let newDog = Dog(name: self.addDogName,
                       dateOfBirth: self.addDogDateOfBirth,
                       image: nil,
                       favoriteToy: self.addDogFavoriteToy,
                       isFavorite: false)
      dogs.append(newDog)

      _ = newDog.createCanine(context: viewContext)

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

struct DogList_Previews: PreviewProvider {
  static var previews: some View {
    DogList(dogs: PetStore.sample.dogs)
  }
}
