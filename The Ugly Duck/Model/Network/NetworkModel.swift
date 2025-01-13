//
//  NetworkModel.swift
//  Rick and Morti
//
//  Created by Lev Vlasov on 15.07.2024.
//

import Foundation

// MARK: - Network Model
struct Results: Codable {
    let id: Int
    let name, species, family, habitat: String
    let placeOfFound, diet, description: String
    let wingspanCM: Int?
    let weightKg: Double
    let image: String
    let heightCM: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, species, family, habitat
        case placeOfFound = "place_of_found"
        case diet, description
        case wingspanCM = "wingspan_cm"
        case weightKg = "weight_kg"
        case image
        case heightCM = "height_cm"
    }
}
