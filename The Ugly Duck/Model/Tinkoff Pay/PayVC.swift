//
//  PayVC.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-15.
//

import UIKit
import SwiftUI

final class PayVC: UIViewController {
    
    //MARK: - Init
    init(price_order_in_rub: Int64, email: String, customerKey: String, order_descriptions: String, stateProperties: StateProperties) {
        self.price_order_in_rub = price_order_in_rub
        self.email = email
        self.order_descriptions = order_descriptions
        self.customerKey = customerKey
        self.stateProperties = stateProperties
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Properties
    @ObservedObject var stateProperties: StateProperties
    
    var price_order_in_rub: Int64
    var email: String
    var order_descriptions: String
    var customerKey: String
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tinkoffPaymentOpen()
        
        // Настройка внешнего вида
        self.view.backgroundColor = .white
    }
    
    private func tinkoffPaymentOpen() {
        let _ = TinkoffPayModel(price_order_in_rub: price_order_in_rub, email: email, customerKey: customerKey, view_controller: self, order_descriptions: order_descriptions) { result in
            switch result {
            case .succeeded:
                self.stateProperties.isPresentPayment = false
            case .error:
                self.stateProperties.isPresentPayment = false
            case .info:
                self.stateProperties.isPresentPayment = false
            }
        }
    }
}
    
    
    
/*
final class PayVC: UIViewController {
  
    //MARK: - Init
      init(stateProperties: StateProperties) {
          self.stateProperties = stateProperties
          super.init(nibName: nil, bundle: nil)
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Properties
    var stateProperties: StateProperties
  
    // Создаем UI элементы
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let checkoutButton = UIButton()

    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настройка внешнего вида
        self.view.backgroundColor = .white
        setupScrollView()
        setupStackView()
        setupCheckoutButton()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Добавляем элементы в stackView
        updateBasketItems()
    }
    
    private func setupCheckoutButton() {
        checkoutButton.setTitle("Go to checkout", for: .normal)
        checkoutButton.titleLabel?.font = .boldSystemFont(ofSize: 22)
        checkoutButton.backgroundColor = .black
        checkoutButton.setTitleColor(.white, for: .normal)
        checkoutButton.layer.cornerRadius = 30
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
        
        stackView.addArrangedSubview(checkoutButton)
        checkoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func updateBasketItems() {
        // Если корзина пуста, показываем сообщение
        if stateProperties.backetProducts.isEmpty {
            let label = UILabel()
            label.text = "Your basket is empty."
            label.font = .systemFont(ofSize: 22)
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
            return
        }
        
        // Получаем список товаров в корзине
        let productsInBacket = stateProperties.get_products_backet()
        
        for product in productsInBacket {
            let productCell = createProductCell(for: product)
            stackView.addArrangedSubview(productCell)
        }
    }
    
    private func createProductCell(for product: Results) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let productImageView = UIImageView()
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.contentMode = .scaleAspectFit
        if let url = URL(string: product.image) {
            productImageView.load(url: url)
        }
        container.addSubview(productImageView)
        
        let productLabel = UILabel()
        productLabel.translatesAutoresizingMaskIntoConstraints = false
        productLabel.text = "\(product.id)"
        productLabel.font = .systemFont(ofSize: 18)
        container.addSubview(productLabel)
        
        let countLabel = UILabel()
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        if let count = stateProperties.backetProducts[product.id], count >= 1 {
            countLabel.text = "x\(count)"
            countLabel.font = .boldSystemFont(ofSize: 14)
            countLabel.textColor = .gray
        }
        container.addSubview(countLabel)
        
        // Размещение элементов на экране
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: container.topAnchor),
            productImageView.leftAnchor.constraint(equalTo: container.leftAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 100),
            productImageView.heightAnchor.constraint(equalToConstant: 100),
            
            productLabel.topAnchor.constraint(equalTo: container.topAnchor),
            productLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 10),
            
            countLabel.topAnchor.constraint(equalTo: productLabel.bottomAnchor, constant: 5),
            countLabel.leftAnchor.constraint(equalTo: productLabel.leftAnchor)
        ])
        
        return container
    }
    
    
    
    @objc private func checkoutButtonTapped() {
        // Действия при нажатии на кнопку
        print("Go to checkout")
    }
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self?.image = image
                    }
                }
            }
        }
    }
}
*/
