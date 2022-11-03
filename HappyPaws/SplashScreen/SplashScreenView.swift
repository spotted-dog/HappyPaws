//
//  SplashScreenView.swift
//  HappyPaws
//
//  Created by Greg Pearman on 11/3/22.
//

import SwiftUI

struct SplashScreenView: View {
  @State private var angle: Double = 0
  @State var textAlpha = 0.0
  @State var isDisplayingError = false
  @State var lastErrorMessage = "" {
    didSet { isDisplayingError = true }
  }

  private var image: Image = .init(systemName: "pawprint")

  static var shouldAnimate = true

  var body: some View {
    GeometryReader { geometry in
      VStack {
        Spacer()

        HStack {
          Text(Constants.General.appName)
            .font(.title)
            .bold()
            .foregroundColor(.blue)
            .opacity(textAlpha)
            .frame(width: geometry.size.width * 0.7)

          Image(Constants.Images.happyPawsLogo)
            .resizable()
            .scaledToFit()
            .opacity(textAlpha)
        }

        Spacer()
      }
      .background(Color.gray)
      .alert("Error", isPresented: $isDisplayingError, actions: {
        Button("Close", role: .cancel) { }
      }, message: {
        Text(lastErrorMessage)
      })
      .onAppear {
        Task {
          await handleAnimations()
        }
      }
    }
  }
}

struct SplashScreenView_Previews: PreviewProvider {
  static var previews: some View {
    SplashScreenView()
  }
}

extension SplashScreenView {
  var animationDuration: Double { return 1.0 }
  var animationDelay: Double { return  0.2 }
  var exitAnimationDuration: Double { return 0.3 }
  var finalAnimationDuration: Double { return 0.4 }

  @MainActor
  func handleAnimations() async {
    await runAnimationPart1()

    if SplashScreenView.shouldAnimate {
      await restartAnimation()
    }
  }

  @MainActor
  func runAnimationPart1() async {
    withAnimation(.easeIn(duration: animationDuration)) {
      textAlpha = 1.0
    }

    do {
      try await Task.sleep(seconds: animationDuration + animationDelay)

      withAnimation(.easeOut(duration: self.exitAnimationDuration)) {
        self.textAlpha = 0.0
      }
    } catch {
      lastErrorMessage = error.localizedDescription
    }
  }

  @MainActor
  func restartAnimation() async {
    do {
      try await Task.sleep(seconds: animationDuration + finalAnimationDuration)
      await self.handleAnimations()
    } catch {
      lastErrorMessage = error.localizedDescription
    }
  }
}
