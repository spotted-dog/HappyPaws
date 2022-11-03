//
//  BreedListRow.swift
//  HappyPaws
//
//  Created by Greg Pearman on 11/3/22.
//

import SwiftUI

struct BreedListRow: View {
  var dogBreed: DogBreed

  var body: some View {
    let frameDimension: CGFloat = 30

    HStack(alignment: .center) {
      Image(systemName: Constants.SFSymbols.pawPrintFill)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: frameDimension, height: frameDimension)

      Text(dogBreed.name)
        .font(.system(.headline))
        .foregroundColor(.gray)
        .padding()
    }
  }
}

struct BreedListRow_Previews: PreviewProvider {
  static var previews: some View {
    BreedListRow(dogBreed: DogBreed.sample())
  }
}
