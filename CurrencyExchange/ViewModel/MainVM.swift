import SwiftUI

final class MainViewModel: ObservableObject {
    @Published var didWatchAd = false
    @Published var rewardAd = Rewarded()
    @Published var coinList: [Coin] = []
    @Published var lastUpdated: String = ""
    @Published var showServiceError = false
    @Published var coinIHave = Coin(coinCode: "")
    @Published var coinIWant = Coin(coinCode: "")
    @Published var userChosenCoins: [[String]]? = UserDefaults.standard.array(forKey: "userChosenCoins") as? [[String]]
    var coinNames: [String] { get { arrangeCoinNameForSearch() }}
    private let url = "https://currencyapi.net/api/v1/rates?key=fb0bcf88dc05920e40179f0d64a42757ba7d&base=USD"
    
    func callService () {
        
        let Request: NetworkingManager
        Request = NetworkingManager.init(endpoint: url)
        Request.httpRequest(httpMethod: .get) { result in
            
            switch result {
                
            case .failure(let error):
                print("error \(error)")
                self.getOldResponse()
                DispatchQueue.main.async { self.showServiceError = true }
                
            case .success (let response):
                let decoder = JSONDecoder()
                do {
                    let responseData = try decoder.decode(CoinGroup.self, from: response)
                    newRates = responseData.rates ?? [:]
                    if self.coinList.isEmpty { self.updateCoinList(responseData.rates ?? [:]) }
                    self.formatDate()
                    self.save(isRefresh: true)
                    self.saveResponse(responseData.rates ?? [:])
                } catch {
                    print("error \(error)")
                }
            }
        }
    }
    
    func save (isRefresh: Bool? = false) {
        var tempArray = userChosenCoins ?? []
        if isRefresh ?? false {
            return
        } else {
            tempArray.append([coinIHave.coinCode, coinIWant.coinCode])
        }
        UserDefaults.standard.set(tempArray, forKey: "userChosenCoins")
        userChosenCoins = tempArray
    }
    
    func delete(at offsets: IndexSet) {
        var tempArray = userChosenCoins ?? []
        tempArray.remove(atOffsets: offsets)
        UserDefaults.standard.set(tempArray, forKey: "userChosenCoins")
        userChosenCoins = tempArray
    }
    
    func move(from source: IndexSet, to destination: Int) {
        var tempArray = userChosenCoins ?? []
        tempArray.move(fromOffsets: source, toOffset: destination)
        UserDefaults.standard.set(tempArray, forKey: "userChosenCoins")
        userChosenCoins = tempArray
    }
    
    func replace(newCoin: String, fromOrTo: CoinRole) {
        var tempArray = userChosenCoins ?? []
        if let index = tempArray.firstIndex(of: [coinIHave.coinCode, coinIWant.coinCode]) {
            switch fromOrTo {
            case .iHave: tempArray[index] = [newCoin, coinIWant.coinCode]
            case .iWant: tempArray[index] = [coinIHave.coinCode, newCoin]
            }
            UserDefaults.standard.set(tempArray, forKey: "userChosenCoins")
            userChosenCoins = tempArray
        }
    }
    
    private func arrangeCoinNameForSearch() -> [String] {
        
        var tempArray: [String] = []
        for i in coinList {
            if i.coinName == "" {
                continue
            }
            tempArray.append(i.coinCountry.lowercased() + " " + i.coinName.lowercased() )
        }
        
        return tempArray.sorted {$0.localizedStandardCompare($1) == .orderedAscending}
    }
    
    private func updateCoinList(_ response: [String:Double]) {
        DispatchQueue.main.async {
            for (code, value) in response {
                let saveRate = Coin(coinRate: value, coinCode: code)
                self.coinList.append(saveRate)
            }
        }
    }
    
    private func formatDate() {
        DispatchQueue.main.async {
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            self.lastUpdated = formatter.string(from:now)
        }
    }
    
    private func saveResponse(_ response: [String:Double]) {
        UserDefaults.standard.set(response, forKey: "savedResponse")
        UserDefaults.standard.set(lastUpdated, forKey: "lastUpdated")
    }
    
    private func getOldResponse() {
        guard let oldResponse = UserDefaults.standard.object(forKey: "savedResponse") as? [String:Double]
            else { return }
        guard let oldDate = UserDefaults.standard.string(forKey: "lastUpdated") else { return }
        DispatchQueue.main.async {
            newRates = oldResponse
            if self.coinList.isEmpty { self.updateCoinList(oldResponse) }
            self.lastUpdated = oldDate
        }
    }
    
    func firstAppLaunch() {
        if (UserDefaults.standard.bool(forKey: "HasLaunchedOnce")) { return }
        else {
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            DispatchQueue.main.async {
                guard let userLocalCoin = Locale.current.currencyCode else { return }
                if userLocalCoin == "USD" {
                    self.userChosenCoins = [[userLocalCoin, "EUR"]]
                } else if userLocalCoin == "EUR" {
                    self.userChosenCoins = [[userLocalCoin, "USD"]]
                } else if Coin(coinCode: userLocalCoin).coinName == "" {
                    return
                } else {
                    self.userChosenCoins = [[userLocalCoin, "USD"], [userLocalCoin, "EUR"]]
                }
                UserDefaults.standard.set(self.userChosenCoins, forKey: "userChosenCoins")
            }
        }
    }
    
    func  startAd() {
        self.rewardAd.showAd(rewardFunction: {
            self.didWatchAd = true
            print("Give Reward")
        })
    }
    
    func callAd() {
        self.rewardAd.requestRewardedVideo()
    }
}
