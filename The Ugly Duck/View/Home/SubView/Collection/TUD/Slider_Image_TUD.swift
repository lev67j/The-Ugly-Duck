//
//  Slider_Image_TUD.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-14.
//

import SwiftUI

struct Slider_Image_TUD: View {
    
    @State private var currentPage: Int = 0
    @State var images: [String] = ["https://tudtoy.com/wp-content/uploads/cola-green-3.jpg", "https://tudtoy.com/wp-content/uploads/cola-green-4.jpg", "https://tudtoy.com/wp-content/uploads/cola-green-5.jpg", "https://tudtoy.com/wp-content/uploads/cola-green-6.jpg", "https://tudtoy.com/wp-content/uploads/cola-green-7.jpg"] // Test image, real be in result.image, now it's only one image
   
    var body: some View {
        VStack {
            let listOfPages = images
            
            GeometryReader { geometry in
                let size = geometry.size
                
                TabView(selection: $currentPage) {
                    ForEach(listOfPages.indices, id: \.self) { index in
                        AsyncImage(url: URL(string: listOfPages[index])) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: size.width, height: 300)
                                .clipped()
                                .tag(index)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 300, height: 300)
                                .padding()
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            withAnimation {
                                currentPage = (currentPage - 1 + listOfPages.count) % listOfPages.count
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundStyle(.white)
                                    .frame(width: 40, height: 40)
                                
                                Image(systemName: "arrow.left")
                                    .resizable()
                                    .frame(width: 16, height: 13)
                                    .foregroundColor(.black)
                            }
                        }
                        .buttonStyle(.plain)
                        .padding(4)
                        
                        Button {
                            withAnimation {
                                currentPage = (currentPage + 1) % listOfPages.count
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundStyle(.white)
                                    .frame(width: 40, height: 40)
                                
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .frame(width: 16, height: 13)
                                    .foregroundColor(.black)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    .padding()
                }
            }    .frame(height: 300)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(listOfPages.indices, id: \.self) { index in
                        Button {
                            withAnimation {
                                currentPage = index
                            }
                        } label: {
                            AsyncImage(url: URL(string: listOfPages[index])) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .opacity(currentPage == index ? 1.0 : 0.6)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 60, height: 60)
                            }
                        }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
            }
        }
    }
}
