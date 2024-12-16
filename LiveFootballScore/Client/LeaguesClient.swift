//
//  LeaguesClient.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 15.12.2024.
//

import Foundation
enum NetworkError: Error{
    case badUrl
    case badRequest
    case invalidResponse
    case decodingerror
}
struct LeaguesClient {

    func getLeaguesByCountry() async throws -> [CountryLeagues] {
        guard let url = URL(string: APIEndpoint.baseURL) else {
            throw NetworkError.badUrl
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = APIEndpoint.headers

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.badRequest
        }

        let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
        return apiResponse.response.leagues
    }
 
}

