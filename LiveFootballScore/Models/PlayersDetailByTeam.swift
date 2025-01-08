//
//  PlayersDetailByTeam.swift
//  LiveFootballScoreTurkish
//
//  Created by Talha Gergin on 8.01.2025.
//

import SwiftUI

// MARK: - APIResponsePlayersByTeam
struct APIResponsePlayersDetailByTeam: Codable {
    let status: String
    let response: ResponsePlayersDetail
}

// MARK: - Response
struct ResponsePlayersDetail: Codable {
    let list: [ListPlayersDetails]
}

// MARK: - List
struct ListPlayersDetails: Codable,Identifiable {
    let id = UUID()
    let title: String
    let members: [MemberDetails]
}
// MARK: - Member
struct MemberDetails: Codable,Identifiable {
    let id: Int
    let name, ccode, cname: String
    let role: RoleDetails
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
struct RoleDetails: Codable {
    let key: KeyDetails
    let fallback: FallbackDetails
}

enum FallbackDetails: String, Codable {
    case attacker = "Attacker"
    case coach = "Coach"
    case defender = "Defender"
    case keeper = "Keeper"
    case midfielder = "Midfielder"
}

enum KeyDetails: String, Codable {
    case attackerLong = "attacker_long"
    case coach = "coach"
    case defenderLong = "defender_long"
    case keeperLong = "keeper_long"
    case midfielderLong = "midfielder_long"
}
