//
//  DogAPI.swift
//  HappyPaws
//
//  Created by Greg Pearman on 10/31/22.
//

import Foundation

enum NetworkError: Error {
  case apiError
  case failedToSave
  case invalidCode
  case invalidURL
}

enum DogAPI {
  static func getAllDogBreeds() async throws -> [DogBreed] {
    do {
      let dogApiBreedsURL = APIConstants.dogAPIHost + APIConstants.dogAPIListBreeds
      let dogBreeds = try await loadJSON(from: dogApiBreedsURL, for: DogBreed.self)
      return dogBreeds
    } catch {
      print("Error getting all breeds: \(error)")
      throw NetworkError.apiError
    }
  }

  static func loadJSON<T: Codable>(from urlString: String, for type: T.Type) async throws -> [T] {
    print("Loading JSON...")
    guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue(APIConstants.dogAPIKey, forHTTPHeaderField: APIConstants.dogAPIAuthHeader)

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
      throw NetworkError.invalidCode
    }

    let jsonObjects: [T] = try JSONDecoder().decode([T].self, from: data)

    print("Created \(jsonObjects.count) JSON Breeds")

    return jsonObjects
  }
}
