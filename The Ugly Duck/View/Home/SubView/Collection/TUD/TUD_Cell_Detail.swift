//
//  TUD_Cell_Detail.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-14.
//

import SwiftUI

struct TUD_Cell_Detail: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var stateProperties: StateProperties
    
    @State var result: Results
    @State private var isAddedToCart: Bool = false  //Redacted Флаг для отслеживания, добавлен ли товар в корзину
    
    var body: some View {
        VStack {
            
            // Back Button
            HStack {
                Button {
                    dismiss()
                } label: {
                    HStack{
                        Image(systemName: "arrowshape.backward")
                            .foregroundStyle(.black)
                        Text("Back")
                            .foregroundStyle(.black)
                    }
                    .padding(10)
                }
                Spacer()
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                
                // Slider Image TUD
                Slider_Image_TUD()
                
                // Parametrs TUD
                VStack {
                    /* TUD | Coca Cola
                     "Fizz Black" art object
                     
                     Size M: 23.6 inch (60 cm)
                     Weight: 3.3 kg
                     
                     $2990
                     */
                }
                
                // Divider
                VStack {
                    
                }
                
                // Button "Add to cart"
                /*VStack {
                    HStack {
                        Spacer()
                        
                        Button {
                            // add in product backet
                            stateProperties.add_product_to_backet(productId: result.id)
                            
                        } label: {
                            Text("Add to cart")
                                .font(.title3.bold())
                                .foregroundStyle(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 30)
                                .background(
                                    Rectangle()
                                        .foregroundStyle(.black)
                                        .clipShape(.rect(cornerRadius: 30)))
                                .padding()
                        }
                    }
                }*/
                
                // Redacted with button "Add to cart" // on 2 circle into - bag in add 2 identically cell - what fuck?
                VStack {
                    HStack {
                        Spacer()
                        
                        if isAddedToCart {
                            // Если товар добавлен, показываем кнопки + и -
                            HStack {
                                Button(action: {
                                    // Уменьшаем количество товара в корзине
                                    if let count = stateProperties.backetProducts[result.id], count > 1 {
                                        stateProperties.backetProducts[result.id] = count - 1
                                    } else {
                                        stateProperties.remove_product_from_backet(productId: result.id)
                                        isAddedToCart = false
                                    }
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.black)
                                }
                                
                                Text("\(stateProperties.backetProducts[result.id] ?? 0)")
                                    .font(.title3)
                                    .foregroundColor(.black)
                                    .frame(width: 40)
                                
                                Button(action: {
                                    // Увеличиваем количество товара в корзине
                                    stateProperties.add_product_to_backet(productId: result.id)
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.black)
                                }
                            }
                        } else {
                            // Если товар не добавлен, показываем кнопку "Add to cart"
                            Button {
                                // Добавляем товар в корзину
                                stateProperties.add_product_to_backet(productId: result.id)
                                isAddedToCart = true  // Отмечаем, что товар добавлен
                            } label: {
                                Text("Add to cart")
                                    .font(.title3.bold())
                                    .foregroundStyle(.white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 30)
                                    .background(
                                        Rectangle()
                                            .foregroundStyle(.black)
                                            .clipShape(.rect(cornerRadius: 30)))
                                    .padding()
                            }
                        }
                    }
                }
            }
        }
    }
}

