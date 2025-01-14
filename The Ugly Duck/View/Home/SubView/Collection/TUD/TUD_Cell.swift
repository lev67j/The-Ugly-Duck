//
//  TUD_Cell.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-13.
//

import SwiftUI

struct TUD_Cell: View {
    
    var result: Results
    
    var body: some View {
        Text("\(result.id)")
            .bold()
            .foregroundStyle(.black)
    }
}
