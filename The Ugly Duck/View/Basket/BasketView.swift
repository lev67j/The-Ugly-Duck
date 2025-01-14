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
            Text("Basket View")
                .font(.largeTitle)
                .bold()
            
           if stateProperties.backetProducts.isEmpty {
                Text("Your basket is empty.")
                    .font(.title2)
            } else {
                let productsInCart = stateProperties.get_products_backet()
                
                // Отображаем список товаров с количеством
                ForEach(productsInCart, id: \.id) { product in
                    HStack {
                        AsyncImage(url: URL(string: product.image)) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 60, height: 60)
                        }
                        
                        Text(product.name)
                            .font(.title3)
                            .padding(.leading)
                        
                        // Отображаем количество товара в корзине
                        if let count = stateProperties.backetProducts[product.id], count > 1 {
                            Text("x\(count)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8) // Adding some spacing between rows
                }
            }
        }
        .padding()
    }
}
