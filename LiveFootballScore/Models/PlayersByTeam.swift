import Foundation

// MARK: - APIResponsePlayersByTeam
struct APIResponsePlayersByTeam: Codable {
    let status: String
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let list: [ListPlayers]
}

// MARK: - List
struct ListPlayers: Codable,Identifiable {
    let id = UUID()
    let title: String
    let members: [Member]
}
// MARK: - Member
struct Member: Codable,Identifiable {
    let id: Int
    let name, ccode, cname: String
    let role: Role
    let excludeFromRanking: Bool
    let shirtNumber, positionID: Int?
    let rating: Double?
    let goals, penalties, assists, rcards: Int?
    let ycards: Int?
    let injured: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, ccode, cname, role, excludeFromRanking, shirtNumber
        case positionID = "positionId"
        case rating, goals, penalties, assists, rcards, ycards, injured
    }
}

// MARK: - Role
struct Role: Codable {
    let key: Key
    let fallback: Fallback
}

enum Fallback: String, Codable {
    case attacker = "Attacker"
    case coach = "Coach"
    case defender = "Defender"
    case keeper = "Keeper"
    case midfielder = "Midfielder"
}

enum Key: String, Codable {
    case attackerLong = "attacker_long"
    case coach = "coach"
    case defenderLong = "defender_long"
    case keeperLong = "keeper_long"
    case midfielderLong = "midfielder_long"
}
