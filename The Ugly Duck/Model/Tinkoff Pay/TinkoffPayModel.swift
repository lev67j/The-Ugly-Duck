//
//  TinkoffPayModel.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-15.
//

import TinkoffASDKUI
import TinkoffASDKCore
import UIKit

final class TinkoffPayModel {
    
    var price_order_in_rub: Int64
    var email: String
    var view_controller: UIViewController
    var order_descriptions: String
    var pay_result: (TinkoffPayResult) -> ()
    
    let credential = AcquiringSdkCredential(
        terminalKey: "TERMINAL_KEY",
        publicKey: "PUBLIC_KEY"
    )

    //MARK: - Init
    init(price_order_in_rub: Int64, email: String, customerKey: String, view_controller: UIViewController, order_descriptions: String, pay_result: @escaping (TinkoffPayResult) -> ()) {
        
        self.price_order_in_rub = price_order_in_rub
        self.email = email
        self.view_controller = view_controller
        self.order_descriptions = order_descriptions
        self.pay_result = pay_result
        
        let coreSDKConfiguration = AcquiringSdkConfiguration(
            credential: credential,
            server: .prod // Используемое окружение
        )
        let uiSDKConfiguration = UISDKConfiguration()
        
        let receipt: Receipt
        let shops: [Shop]
        let receipts: [Receipt]

        let orderOptions = OrderOptions(
            /// Идентификатор заказа в системе продавца
            orderId: UUID().uuidString,
            // Полная сумма заказа в копейках
            amount: price_order_in_rub * 100, // "*" for switch rub in kopecks
            // Краткое описание заказа
            description: order_descriptions,
            // Данные чека
            receipt: nil,
            // Данные маркетплейса. Используется для разбивки платежа по партнерам
            shops: nil,
            // Чеки для каждого объекта в `shops`.
            // В каждом чеке необходимо указывать `Receipt.shopCode` == `Shop.shopCode`
            receipts: nil,
            // Сохранить платеж в качестве родительского
            savingAsParentPayment: false
        )

        let customerOptions = CustomerOptions(
            // Идентификатор покупателя в системе продавца.
            // С помощью него можно привязать карту покупателя к терминалу после успешного платежа
            customerKey: customerKey,
            // Email покупателя
            email: email
        )

        // Используется для редиректа в приложение после успешного или неуспешного совершения оплаты с помощью `T-Pay`
        // В иных сценариях передавать эти данные нет необходимости
        let paymentCallbackURL = PaymentCallbackURL(
            successURL: "SUCCESS_URL",
            failureURL: "FAIL_URL"
        )
        
        let paymentOption: PaymentOptions = .init(orderOptions: orderOptions, customerOptions: customerOptions, paymentCallbackURL: paymentCallbackURL)
        
        let paymentFlow: PaymentFlow = .full(paymentOptions: paymentOption)
        
        let config: MainFormUIConfiguration = .init(orderDescription: order_descriptions)
        do {
            let sdk = try AcquiringUISDK(
                coreSDKConfiguration: coreSDKConfiguration,
                uiSDKConfiguration: uiSDKConfiguration
            )
            
            sdk.presentMainForm(on: view_controller, paymentFlow: paymentFlow, configuration: config) { result in
                switch result {
                    
                case .succeeded(let succeeded):
                    print(succeeded)
                    pay_result(.succeeded)
                case .failed(let error):
                    print(error)
                    pay_result(.error)
                case .cancelled(let info):
                    print(info ?? "")
                    pay_result(.info)
                }
            }
         } catch {
            // Ошибка может возникнуть при некорректном параметре `publicKey`
            assertionFailure("\(error)")
        }
    }
}
