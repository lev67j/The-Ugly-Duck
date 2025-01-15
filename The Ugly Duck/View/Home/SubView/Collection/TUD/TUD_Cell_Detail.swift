//
//  TUD_Cell_Detail.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-14.
//

private func firstStartApp() {
    let firstLaunch = UserDefaults().bool(forKey: "isFirstOpenApp")

    if firstLaunch == false {
        
        // base 10 rounds
        
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        UserDefaults().set(true, forKey: "isFirstOpenApp")
    }
}

import SwiftUI

struct TUD_Cell_Detail: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var stateProperties: StateProperties
    
    @State var result: Results
    @State var isAddedToBacket = UserDefaults().bool(forKey: "isAddedToBacket")

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
                VStack {
                    HStack {
                        Spacer()
                         if (stateProperties.backetProducts[result.id] ?? 0 > 0) {
                            
                            // Button + and -
                            VStack {
                                HStack {
                                    
                                    // minus button
                                    Button {
                                        if let count = stateProperties.backetProducts[result.id], count > 1 {
                                            stateProperties.backetProducts[result.id] = count - 1
                                        } else {
                                            stateProperties.remove_product_from_backet(productId: result.id)
                                        }
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(.white)
                                    }
                                    
                                    // Number this products in backet
                                    Text("\(stateProperties.backetProducts[result.id] ?? 0)")
                                        .font(.title3.bold())
                                        .foregroundColor(.white)
                                        .frame(width: 40)
                                    
                                    // plus button
                                    Button {
                                        stateProperties.add_product_to_backet(productId: result.id)
                                    } label: {
                                        Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal, 30)
                                .background(
                                    Rectangle()
                                        .foregroundStyle(.black)
                                        .clipShape(.rect(cornerRadius: 30)))
                                .padding()
                            }
                         } else {
                            
                            // Button "Add to cart"
                            Button {
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
                    }
                    .padding()
                }
            }
        }
    }
}

