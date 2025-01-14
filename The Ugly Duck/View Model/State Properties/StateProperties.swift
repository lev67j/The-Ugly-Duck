//
//  StateProperties.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-13.
//

import Foundation

final class StateProperties: ObservableObject {
    
    //MARK: - Properties
    @Published var apiService: APIService = APIService()
    
    // Словарь с ID товара и количеством
    @Published var backetProducts: [Int: Int] = [:]
    
    // Добавить товар в корзину
    func add_product_to_backet(productId: Int) {
        // Если товар уже есть, увеличиваем его количество
        if let currentCount = backetProducts[productId] {
            backetProducts[productId] = currentCount + 1
        } else {
            // Если товара нет в корзине, добавляем его с количеством 1
            backetProducts[productId] = 1
        }
    }
    
    // Удалить товар из корзины
    func remove_product_from_backet(productId: Int) {
        backetProducts.removeValue(forKey: productId)
    }
    
    // Получить список товаров в корзине по ID
    func get_products_backet() -> [Results] {
        return apiService.results.filter { backetProducts.keys.contains($0.id) }
    }
}
