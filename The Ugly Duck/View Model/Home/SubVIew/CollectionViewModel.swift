//
//  CollectionViewModel.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-13.
//

import Foundation

final class CollectionViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var selectedCollection = "All"
    
    @Published var collections: [Collections] = [
        Collections(id: UUID(), name: "All"),
        Collections(id: UUID(), name: "Legengs"),
        Collections(id: UUID(), name: "Artists"),
        Collections(id: UUID(), name: "Brands")
    ]
}

