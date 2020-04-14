//import SwiftUI
//import StoreKit
//import GoogleMobileAds
//
//private enum Constants: String {
//    case or = "Or"
//    case close = "Close"
//    case star = "star"
//    case restoreText = "Restore Purchases"
//    case unlockText = "Unlock All Currencies"
//    case videoText = "Watch a video to unlock"
//    case buyFailedMessage = "Purchase failed"
//    case adUnitId = "ca-app-pub-3940256099942544/1712485313"
//    case purchaseText = "One time purchase to unlock everything"
//    case unlockExplaination = "gain access to all 160 currencies for one day by watching an Ad video, or make a one time purchase to support the developer and unlock permanent access to all currencies."
//    func localizedString() -> String {
//        return NSLocalizedString(self.rawValue, comment: "")
//    }
//}
//
//struct Offer: View {
//    var rewardAd: Rewarded
//    @Binding private var showModel: Bool
//    @ObservedObject var purchaseManager = IAPManager()
//
//    init(showModel: Binding<Bool>) {
//        self._showModel = showModel
//        self.rewardAd = Rewarded()
//    }
//
//    var body: some View {
//        VStack {
//            if hideButtonIfOnIpad() {
//                Spacer()
//            } else {
//                ZStack {
//                    Button(Constants.close.localizedString()) {
//                        self.showModel = false
//                    }
//                    .foregroundColor(Color.orange)
//                    .padding(.leading, 15)
//                }.frame(width: width, alignment: .leading)
//                    .padding(.top, 50)
//                Spacer()
//            }
//
//            Image(Constants.star.rawValue).resizable()
//                .frame(width: 180, height: 180)
//                .padding(.top, -80)
//            Text(Constants.unlockText.localizedString())
//                .foregroundColor(.orange)
//                .font(Font.custom(rubik, size: 28))
//                .padding(.top, -5)
//            Text(Constants.unlockExplaination.localizedString())
//                .frame(width: width / 1.5)
//                .multilineTextAlignment(.center)
//                .foregroundColor(.white)
//                .font(Font.custom(rubik, size: 16))
//                .padding(.top, 10)
//                .padding(.bottom, 10)
//            Button(action: {
//                self.rewardAd.showAd(rewardFunction: {
//                    print("Give Reward")
//                }
//                )  }){
//                    Text(Constants.videoText.localizedString())
//                        .multilineTextAlignment(.center)
//            }
//            .font(Font.custom(rubik, size: 16))
//            .frame(width: 220, height: 50, alignment: .center)
//            .background(Color(melon))
//            .foregroundColor(.black)
//            .opacity(0.8)
//            .cornerRadius(20)
//            .shadow(radius: 100)
//            .padding(5)
//            .onAppear() { self.loadProductsAndAd() }
//
//            Text(Constants.or.localizedString())
//                .foregroundColor(.orange)
//                .font(Font.custom(rubik, size: 20))
//                .padding(5)
//
//            HStack {
//
//                if purchaseManager.offerState == .loading {
//                    ActivityIndicator(isAnimating: true)
//                        .configure { $0.color = .orange }
//                } else if purchaseManager.offerState == .success {
//                    Image(systemName: "checkmark")
//                        .foregroundColor(.green)
//                } else {
//                    Button(Constants.purchaseText.localizedString()) {
//                        self.purchaseManager.offerState = .loading
//                        self.purchaseManager.buy()
//                    }
//                    .font(Font.custom(rubik, size: 16))
//                    .frame(width: 330, height: 50, alignment: .center)
//                    .background(Color(darkBlue))
//                    .foregroundColor(.orange)
//                    .multilineTextAlignment(.center)
//                    .opacity(0.8)
//                    .cornerRadius(20)
//                    .shadow(radius: 100)
//                    .padding(5)
//                }
//            }.frame(width: 330, height: 50, alignment: .center)
//
//            Button(Constants.restoreText.localizedString()) {
//                self.purchaseManager.restorePurchase()
//            }
//            .foregroundColor(.orange)
//            .font(Font.custom(rubik, size: 14))
//            .padding(.top, 30)
//            Spacer()
//        }.frame(width: width, height: height, alignment: .top)
//            .background(Color(ebony))
//            .alert(isPresented: $purchaseManager.buyFailed) {
//                Alert(title: Text(Constants.buyFailedMessage.localizedString()), message: Text(""), dismissButton: .default(Text(Constants.close.localizedString())))
//        }
//    }
//
//    private func loadProductsAndAd() {
//        DispatchQueue.global().async {
//            self.rewardAd.requestRewardedVideo()
//        }
//        DispatchQueue.global().async {
//            print("getting product from server")
//            self.purchaseManager.getProducts { (result) in
//                switch result {
//                case .success(let products): self.purchaseManager.products = products
//                DispatchQueue.main.async {
//                    self.purchaseManager.offerState = .idle
//                }
//                print("received product \(products) from apple")
//                case .failure: print("error in getting product")
//                }
//            }
//        }
//    }
//    private func hideButtonIfOnIpad() -> Bool {
//        switch UIDevice.current.userInterfaceIdiom {
//        case .phone:
//            return false
//        case .pad:
//            return  true
//        default:
//            return  false
//        }
//    }
//}
//
//struct Offer_Previews: PreviewProvider {
//    @State static var staticBool = true
//    static var previews: some View {
//        Offer(showModel: $staticBool)
//    }
//}
//
//
//extension GADRewardBasedVideoAd {
//    func rewardBasedVideoAdDidClose (_rewardBasedVideoAd: GADRewardBasedVideoAd) {
//        print("finished")
//    }
//}
