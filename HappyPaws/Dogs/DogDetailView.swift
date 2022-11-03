//
//  DogDetailView.swift
//  HappyPaws
//
//  Created by Greg Pearman on 11/2/22.
//

import SwiftUI

struct DogDetailView: View {
  var dog: Dog
  
  var body: some View {
    let cornerRadius: CGFloat = 10
    
    return HStack(alignment: .top) {
      VStack {
        if let dogImage = dog.image {
          Image(dogImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 120, height: 120)
            .cornerRadius(cornerRadius)
        } else {
          Image(systemName: Constants.SFSymbols.pawPrintFill)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 120, height: 120)
        }
        
        // swiftlint:disable multiple_closures_with_trailing_closure
        Button(action: {
          self.dog.isFavorite.toggle()
        }) {
          if dog.isFavorite {
            Image(systemName: "heart.fill")
          } else {
            Image(systemName: "heart")
          }
          Text("Favorite")
            .font(.body)
            .fontWeight(.bold)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .frame(width: 120, alignment: .leading)
        .accessibilityIdentifier("FavoriteButton")
      }
      
      VStack(alignment: .leading) {
        Text("Name: \(dog.name)")
          .font(.system(.headline, design: .rounded))
          .fontWeight(.black)
          .foregroundColor(.gray)
          .padding(.vertical, 4)
          .accessibilityIdentifier("PetDetailsViewName")
        
        Text("Date of Birth: \(dog.getDateOfBirthString())")
          .font(.system(.headline, design: .rounded))
          .fontWeight(.black)
          .foregroundColor(.gray)
          .padding(.vertical, 4)
          .accessibilityIdentifier("PetDetailsViewDOB")
        
        if let favoriteToy = dog.favoriteToy {
          Text("Favorite Toy: \(favoriteToy)")
            .font(.system(.headline, design: .rounded))
            .fontWeight(.black)
            .foregroundColor(.gray)
            .padding(.vertical, 4)
        }
      }
    }
    .navigationBarTitle(dog.name, displayMode: .inline)
  }
}

struct DogDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let petStore = PetStore.sample
    let dog = petStore.dogs.first!
    DogDetailView(dog: dog)
  }
}
