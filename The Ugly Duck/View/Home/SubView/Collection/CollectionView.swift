//
//  CollectionView.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-13.
//

import SwiftUI

struct CollectionView: View {
    
    @EnvironmentObject var stateProperties: StateProperties
    @ObservedObject var collectionVM: CollectionViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                // Header for Selected Collections
                VStack {
                    HStack {
                        Text("Collectibles")
                            .font(.title2.bold())
                            .padding()
                        
                        Spacer()
                        
                        HStack {
                            ForEach(stateProperties.apiService.results.prefix(4), id: \.id) { result in   // ".prefix(4)" only for test api!
                                CollectionCell(collectionVM: collectionVM, result: result)
                            }
                        }
                        .padding()
                    }
                }
                .padding()
                
                // Collection TUD  | Switch "result.species" on "result.collection"
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(stateProperties.apiService.results, id: \.id) { result in
                            if result.species == collectionVM.selectedCollection {
                                NavigationLink {
                                    TUD_Cell_Detail(result: result)
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    TUD_Cell(result: result)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}
