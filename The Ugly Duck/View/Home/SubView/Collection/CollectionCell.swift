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
    
    @State var collections: Collections
    
    var body: some View {
        VStack {
            Button {
                collectionVM.selectedCollection = collections.name
            } label: {
                Text(collections.name)
                    .bold()
                    .foregroundStyle(collectionVM.selectedCollection == collections.name ? .black : .gray.opacity(0.7))
            }
            .buttonStyle(.plain)
        }
    }
}

