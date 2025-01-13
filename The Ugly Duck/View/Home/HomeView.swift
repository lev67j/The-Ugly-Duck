//
//  HomeView.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-13.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var stateProperties: StateProperties
    @StateObject private var collectionVM = CollectionViewModel()
    
    var body: some View {
        VStack {
            CollectionView(collectionVM: collectionVM)
        }
    }
}


