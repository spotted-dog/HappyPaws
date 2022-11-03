//
//  WelcomeView.swift
//  HappyPaws
//
//  Created by Greg Pearman on 10/30/22.
//

import SwiftUI

struct WelcomeView: View {
  @State private var isShowingOnboardingSheet = false
  var systemName: String = Constants.SFSymbols.pawPrintCircle

  var body: some View {
    VStack {
      HStack {
        Text("Welcome!")
          .bold()
          .multilineTextAlignment(.leading)
          .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading)
          .font(.title)
          .foregroundColor(.gray)
          .padding(.horizontal, 20)
          .padding(.vertical, 8)

        Spacer()

        // swiftlint:disable multiple_closures_with_trailing_closure
        Button(action: {
          isShowingOnboardingSheet.toggle()
        }) {
          Image(systemName: systemName)
            .font(.title)
            .foregroundColor(.blue)
            .frame(
              maxWidth: .infinity,
              maxHeight: .infinity,
              alignment: .topTrailing)
            .padding()
            .accessibilityIdentifier("ShowOnboardingSheetButton")
        }
        .sheet(isPresented: $isShowingOnboardingSheet) {
          OnboardingView()
        }
      }
      .frame(height: .minimum(100, 100), alignment: .top)

      Spacer()

      VStack {
        Text(Constants.General.appWelcome)
        .font(.headline)
        .foregroundColor(.blue)
        .padding()

        Spacer()
      }
    }
    .padding()
    .navigationBarTitle("Welcome")
  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
    WelcomeView()
      .preferredColorScheme(.dark)
    WelcomeView()
      .previewInterfaceOrientation(.landscapeLeft)
    WelcomeView()
      .preferredColorScheme(.dark)
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
