//
//  OnboardingView.swift
//  HappyPaws
//
//  Created by Greg Pearman on 11/3/22.
//

import SwiftUI

struct OnboardingView: View {
  @Environment(\.dismiss) var dismiss

  var body: some View {
    VStack {
      VStack {
        Text(Constants.General.appName)
          .font(.largeTitle)
          .bold()
          .foregroundColor(.blue)
          .frame(
            maxHeight: .infinity,
            alignment: .top
          )

        Image(Constants.Images.happyPawsLogo)
          .resizable()
          .scaledToFit()
          .frame(
            maxHeight: .infinity,
            alignment: .top)
      }

      Text("\(Constants.General.appDescription) Current features are:")
        .multilineTextAlignment(.leading)
        .font(.body)
        .padding()

      List {
        Text("✅ List of all your dogs")
        Text("✅ Detailed information of each dog")
        Text("✅ List of Dog Breeds")
      }
      .listStyle(.inset)

      // swiftlint:disable multiple_closures_with_trailing_closure
      Button(action: {
        dismiss()
      }) {
        Text("Close")
          .padding()
      }
      .frame(
        maxWidth: .infinity
      )
      .background(Color.blue)
      .foregroundColor(.white)
      .accessibilityIdentifier("CloseOnboardingViewButton")
    }
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
    OnboardingView()
      .preferredColorScheme(.dark)
    OnboardingView()
      .previewInterfaceOrientation(.landscapeLeft)
    OnboardingView()
      .preferredColorScheme(.dark)
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
