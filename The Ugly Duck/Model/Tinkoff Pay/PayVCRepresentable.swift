//
//  PayVCRepresentable.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-15.
//

import SwiftUI

struct PayVCRepresentable: UIViewControllerRepresentable {
  
    @EnvironmentObject var stateProperties: StateProperties
    
    // From BacketView
    @State var price_order_in_rub: Int64
    @State var email: String
    @State var order_descriptions: String
    @State var customerKey: String
 
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = PayVC(price_order_in_rub: price_order_in_rub, email: email, customerKey: customerKey, order_descriptions: order_descriptions, stateProperties: stateProperties)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
    }
}
