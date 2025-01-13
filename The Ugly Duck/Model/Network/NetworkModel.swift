//
//  NetworkModel.swift
//  Rick and Morti
//
//  Created by Lev Vlasov on 15.07.2024.
//

import Foundation

// MARK: - Network Model
struct NetworkModel: Codable {
    let results: [Results]
}

// MARK: - Result
struct Results: Codable, Identifiable {
    let id: Int
    let name: String
    let collection: String
    let image: URL
    let url: String
}

struct TUD: Codable, Identifiable {
    let id: Int
    let name: String
    let collection: String
    let image: [URL]
    let height_TUD: Int
    let weigth_TUD: Int
    let packaging: String
    let length_box: Int
    let height_box: Int
    let width_box: Int
}


struct Collections: Codable, Identifiable {
    let id: UUID
    let name: String
}
