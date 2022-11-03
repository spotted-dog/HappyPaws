//
//  DogListRow.swift
//  HappyPaws
//
//  Created by Greg Pearman on 11/2/22.
//

import SwiftUI

struct DogListRow: View {
  var dog: Dog

  var body: some View {
    let frameDimension: CGFloat = 30

    HStack(alignment: .center) {
      if let dogImage = dog.image {
        Image(dogImage)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: frameDimension, height: frameDimension)
      } else {
        Image(systemName: Constants.SFSymbols.pawPrintFill)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: frameDimension, height: frameDimension)
      }

      Text(dog.name)
        .font(.system(.headline))
        .foregroundColor(.gray)
        .padding()
    }
  }
}

struct DogListRow_Previews: PreviewProvider {
  static var previews: some View {
    DogListRow(dog: PetStore.sample.dogs.first!)
  }
}
