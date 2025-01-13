//
//  CollectionCell.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-13.
//

import SwiftUI

struct CollectionCell: View {
    
    @EnvironmentObject var stateProperties: StateProperties
    @ObservedObject var collectionVM: CollectionViewModel
    
    @State var result: Results
    
    var body: some View {
        VStack(spacing: 10) {
            Button {
                collectionVM.selectedCollection = result.species
            } label: {
                Text("\(result.id)")
                    .bold()
                    .foregroundStyle(collectionVM.selectedCollection == result.species ? .black : .gray.opacity(0.9))
            }
            .buttonStyle(.plain)
        }
    }
}

