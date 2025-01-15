//
//  BasketView.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-13.
//

import SwiftUI

struct BasketView: View {
    @EnvironmentObject var stateProperties: StateProperties  
    
    var body: some View {
        VStack {
               
           if stateProperties.backetProducts.isEmpty {
                Text("Your basket is empty.")
                    .font(.title2)
            } else {
                let productsInBacket = stateProperties.get_products_backet()
                
                // List Products
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(productsInBacket, id: \.id) { product in
                        GeometryReader { geometry in
                            let size = geometry.size
                            
                            VStack(spacing: 1) {
                                // Product Cell
                                HStack {
                                    AsyncImage(url: URL(string: product.image)) { image in
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 100, height: 100)
                                    }
                                    .padding(10)
                                    
                                    Text("\(product.id)")
                                        .font(.title3)
                                    
                                    if let count = stateProperties.backetProducts[product.id], count >= 1 {
                                        Text("x\(count)")
                                            .font(.subheadline.bold())
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding()
                            }
                            .padding()
                            .frame(width: size.width, height: size.height, alignment: .center)
                        }
                        .padding(.top, 65)
                    }
                }
                
                // Button for Paymant
                VStack {
                    Button {
                        //https://youtu.be/0Ko69GWZcI0?si=GkRqHyOb_ht8Cv3g
                        stateProperties.isPresentPayment = true
                    } label: {
                        Text("Go to checkout")
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 30)
                            .background(
                                Rectangle()
                                    .foregroundStyle(.black)
                                    .clipShape(.rect(cornerRadius: 30)))
                            .padding()
                    }
                    .buttonStyle(.plain)
                    .sheet(isPresented: $stateProperties.isPresentPayment) {
                        PayVCRepresentable(price_order_in_rub: 0,
                                           email: "no", // email from account
                                           order_descriptions: "descript",
                                           customerKey: "no") // id from account
                    }
                }
            }
        }
        .padding()
    }
}
