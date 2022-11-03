//
//  BreedDetailView.swift
//  HappyPaws
//
//  Created by Greg Pearman on 11/3/22.
//

import SwiftUI

struct BreedDetailView: View {
  @ObservedObject var dogBreed: DogBreed

  var body: some View {
    let cornerRadius: CGFloat = 10
    let imageDimension: CGFloat = 200

    return VStack(alignment: .leading) {
      Image(systemName: Constants.SFSymbols.pawPrintFill)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: imageDimension, height: imageDimension)
        .cornerRadius(cornerRadius)

      HStack(alignment: .top) {
        Text("Name: ")
          .font(.system(.title))
          .fontWeight(.bold)
          .foregroundColor(.gray)

        Text("\(dogBreed.name)")
          .font(.system(.title))
          .foregroundColor(.gray)
          .accessibilityIdentifier("DogBreedDetailsViewName")
      }
      .padding(.vertical, 4)

      HStack(alignment: .top) {
        Text("Breed Group: ")
          .font(.system(.headline))
          .fontWeight(.bold)
          .foregroundColor(.gray)
        Text("\(dogBreed.breedGroup ?? "")")
          .font(.system(.headline))
          .foregroundColor(.gray)
          .accessibilityIdentifier("DogBreedDetailsViewBreedGroup")
      }
      .padding(.vertical, 4)

      HStack(alignment: .top) {
        Text("Breed For: ")
          .font(.system(.headline))
          .fontWeight(.bold)
          .foregroundColor(.gray)
        Text("\(dogBreed.breedFor ?? "")")
          .font(.system(.headline))
          .foregroundColor(.gray)
          .accessibilityIdentifier("DogBreedDetailsViewBreedFor")
      }
      .padding(.vertical, 4)

      HStack(alignment: .top) {
        Text("Origin: ")
          .font(.system(.headline))
          .fontWeight(.bold)
          .foregroundColor(.gray)
        Text("\(dogBreed.origin ?? "")")
          .font(.system(.headline))
          .foregroundColor(.gray)
          .accessibilityIdentifier("DogBreedDetailsViewOrigin")
      }
      .padding(.vertical, 4)

      HStack(alignment: .top) {
        Text("Country Code: ")
          .font(.system(.headline))
          .fontWeight(.bold)
          .foregroundColor(.gray)
        Text("\(dogBreed.countryCode ?? "")")
          .font(.system(.headline))
          .foregroundColor(.gray)
          .accessibilityIdentifier("DogBreedDetailsViewCountryCode")
      }
      .padding(.vertical, 4)

      HStack(alignment: .top) {
        Text("Life Span: ")
          .font(.system(.headline))
          .fontWeight(.bold)
          .foregroundColor(.gray)
        Text("\(dogBreed.lifeSpan ?? "")")
          .font(.system(.headline))
          .foregroundColor(.gray)
          .accessibilityIdentifier("DogBreedDetailsViewLifeSpan")
      }
      .padding(.vertical, 4)

      HStack(alignment: .top) {
        Text("Temperment: ")
          .font(.system(.headline))
          .fontWeight(.bold)
          .foregroundColor(.gray)
        Text("\(dogBreed.temperament ?? "")")
          .font(.system(.headline))
          .foregroundColor(.gray)
          .accessibilityIdentifier("DogBreedDetailsViewTemperment")
      }
      .padding(.vertical, 4)
    }
    .navigationBarTitle(dogBreed.name, displayMode: .inline)
  }
}

struct BreedDetailView_Previews: PreviewProvider {
  static var previews: some View {
    BreedDetailView(dogBreed: DogBreed.sample())
  }
}
