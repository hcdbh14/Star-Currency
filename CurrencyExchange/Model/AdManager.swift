// Test Ad Unit = ca-app-pub-3940256099942544/1712485313
import SwiftUI
import GoogleMobileAds

enum UserUnlockType: Int8 {
    case locked = 0
    case dailyUnlock = 1
    case permanentUnlock = 2
}

final class Rewarded: NSObject, GADRewardedAdDelegate {
    
    var finishedWatchingVideo = false
    var rewardFunction: (() -> Void)? = nil
    let userDefaultPurchase = UserDefaults.standard.integer(forKey: "unlockType")
    var rewardedAd: GADRewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-3940256099942544/1712485313")
    
    func requestRewardedVideo() {
        let request = GADRequest()
        self.rewardedAd.load(request)
    }
    
    func showAd(rewardFunction: @escaping () -> Void) {
        if self.rewardedAd.isReady {
            self.rewardFunction = rewardFunction
            let root = UIApplication.shared.windows.last?.rootViewController
            self.rewardedAd.present(fromRootViewController: root!, delegate: self)
        }
        else {
            print("Ad Not Ready")
        }
    }
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        if let rewardUser = rewardFunction {
            rewardUser()
            self.finishedWatchingVideo = true
        }
    }
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        
        if finishedWatchingVideo && userDefaultPurchase != UserUnlockType.permanentUnlock.rawValue {
            UserDefaults.standard.set(NSDate().timeIntervalSince1970, forKey: "lastWatched")
            UserDefaults.standard.set(UserUnlockType.dailyUnlock.rawValue, forKey: "unlockType")
        }
    }
}


