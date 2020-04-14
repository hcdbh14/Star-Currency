import StoreKit
import SwiftUI

//enum OfferState {
//    case idle
//    case success
//    case loading
//}

enum UserUnlockType: Int8 {
    case locked = 0
    case dailyUnlock = 1
    case permanentUnlock = 2
}
//
//enum IAPManagerError: Error {
//    case noProductIDsFound
//    case noProductsFound
//    case paymentWasCancelled
//    case productRequestFailed
//}
//
//class IAPManager: NSObject, ObservableObject {
//    @Published var buyFailed = false
//    @Published var offerState = OfferState.loading
//    let productId = "unlock"
//    var products: ([SKProduct])?
//    var onReceiveProductsHandler: ((Result<[SKProduct], IAPManagerError>) -> Void)?
//
//    override init() {
//        super.init()
//        SKPaymentQueue.default().add(self)
//    }
//
//    func getProducts(withHandler productsReceiveHandler: @escaping (_ result: Result<[SKProduct], IAPManagerError>) -> Void) {
//        // Keep the handler (closure) that will be called when requesting for
//        // products on the App Store is finished.
//        onReceiveProductsHandler = productsReceiveHandler
//
//        // Initialize a product request.
//        let request = SKProductsRequest(productIdentifiers: Set([productId]))
//
//        // Set self as the its delegate.
//        request.delegate = self
//
//        // Make the request.
//        request.start()
//    }
//
//    func buy() {
//        guard let product = products?[0] else { return }
//        let payment = SKPayment(product: product)
//        SKPaymentQueue.default().add(payment)
//    }
//
//    func restorePurchase() {
//        SKPaymentQueue.default().restoreCompletedTransactions()
//    }
//
//    func stopObserving() {
//        SKPaymentQueue.default().remove(self)
//    }
//
//}
//
//
//
//extension IAPManager: SKProductsRequestDelegate {
//
//    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        let products = response.products
//        if products.count > 0 {
//            onReceiveProductsHandler?(.success(products))
//        } else {
//            print(response.invalidProductIdentifiers)
//            onReceiveProductsHandler?(.failure(.noProductsFound))
//        }
//    }
//
//    func getPriceFormatted(for product: SKProduct) -> String? {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
//        formatter.locale = product.priceLocale
//        return formatter.string(from: product.price)
//    }
//}
//
//extension IAPManager: SKPaymentTransactionObserver {
//    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//        for transaction in transactions {
//            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
//            switch transaction.transactionState {
//            case .deferred: return
//            case .purchasing: return
//            case .failed:
//                self.offerState = .idle
//                self.buyFailed = true
//            case .purchased, .restored:
//                UserDefaults.standard.set(UserUnlockType.permanentUnlock.rawValue, forKey: "unlockType")
//                self.offerState = .success
//            default: self.offerState = .idle
//            }
//        }
//    }
//
//    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
//
//        if queue.transactions.isEmpty == false {
//            switch queue.transactions[0].payment.productIdentifier as String {
//            case "unlock":
//                print("Purchase restored")
//                UserDefaults.standard.set(UserUnlockType.permanentUnlock.rawValue, forKey: "unlockType")
//                self.offerState = .success
//                break
//            default:
//                print("No purchase found")
//                break
//            }
//        }
//    }
//}
//
//extension SKPaymentTransactionState {
//    func status() -> String {
//        switch self {
//        case .deferred: return ""
//        case .failed: return "transaction failed"
//        case .purchased: return "purchased"
//        case .purchasing: return "purchasing"
//        case .restored: return "restored"
//        @unknown default:
//            fatalError()
//        }
//    }
//}
