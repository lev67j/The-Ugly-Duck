//
//  CollectionView.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-13.
//

import SwiftUI

struct CollectionView: View {
    
    @EnvironmentObject var stateProperties: StateProperties
    @State var collectionVM: CollectionViewModel
    
    var body: some View {
        VStack {
            // Header for Selected Collections
            VStack {
                HStack {
                    Text("Collectibles")
                        .font(.title2.bold())
                    
                    Spacer()
                    
                    HStack {
                        ForEach(collectionVM.collections, id: \.id) { collections in
                            CollectionCell(collectionVM: collectionVM, collections: collections)
                        }
                    }
                    
                    
                }
                .padding()
            }
            
            // Foreach cell in dependens on collectionVM.selectedCollection
            VStack {
                ForEach(stateProperties.apiService.results) { result in
                    result.title == collectionVM.selectedCollection {
                        Text(result.title)
                            .font(.bold())
                    }
                }
            }
        }
    }
}
