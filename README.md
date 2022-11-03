# HappyPaws

## Overview
This application is a reference application to demonstrate different capabilities and features
of my iOS development skills. This application favors newer SwiftUI and Modern Concurrency over
older UIKit and Grand Central Dispatch (GCD) and Operation/OperationQueue.

## Features
Features here are continually evolving as my knowledge and experience evolve. Here are some of
the key features to look for at this time:

### General
- Use of tab view that remembers which tab you were last on when you left the application.
- CoreData for long term persistence of Canines and Canine Breeds
- Modern concurrency
- Project structure
  - Core folder contains components like data models, extensions and constants that are used throughout the application
  - data holds more pure data type components for things like CoreData and API
  - domain holds models that contain business rules and properties but still used throughout the application
  - Then there are groups that represent feature specific capabilites. These groups hold views and models that are specific the feature
- Static Code Analysis
  - Added [SwiftLint](https://github.com/realm/SwiftLint) to the project

### Welcome
- Welcome view that welcomes the app user
- Sheet to give onboarding details and app feature details

### Dogs
- List / Detail view with list item navigation for dogs

### Dog Breeds
- List / Detail view with list item navigation for dog breeds

### Unit Testing

### UI Testing

## Use
In order to run this application, you will need to get a developer API key which is used
when retrieving the dog breeds the initial time the application starts. This API is
located at [TheDogAPI](https://thedogapi.com). A free plan which includes the API key
is available on the [Pricing Page](https://thedogapi.com/#pricing).

Once you have signed up, you will receive an email that will include your API key.
This API key needs to be added to the "dogAPIKey" property found in the HappyPaws > 
Core > data > api > APIConstants.swift file. Simply replace the existing "<your API key here>"
string with you actual API key.

Then you are ready to build and run the application.

