import Foundation

// MARK: - APIResponsePlayersByTeam
struct APIResponsePlayersImage: Codable {
    let status: String
    let response: ResponseImage
}

// MARK: - Response
struct ResponseImage: Codable {
    let url: String
}
