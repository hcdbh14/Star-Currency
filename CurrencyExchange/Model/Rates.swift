import SwiftUI

public var newRates: [String:Double]?

class Rates: ObservableObject {
    @Published var previousRates: [String:Double]?
    private let url = "https://api.exchangeratesapi.io/"
    
    func callService () {
        let Request: NetworkingManager
        let previousDay = yesterday()
        Request = NetworkingManager.init(endpoint: "\(url + previousDay)?base=USD")
        
        Request.httpRequest(httpMethod: .get) { result in
            
            switch result {
            case .failure(let error):
                print("error \(error)")
                
            case .success (let response):
                let decoder = JSONDecoder()
                do {
                    let responseData = try decoder.decode(CoinGroup.self, from: response)
                    DispatchQueue.main.async {
                        self.previousRates = responseData.rates ?? [:]
                    }
                } catch {
                    print("error \(error)")
                }
            }
        }
    }
    
    func returnRateChange(coinCode: String) -> some View {
        var body: some View {
            get {
                guard let previousRate = previousRates?[coinCode] else { return Image(systemName: "clear")
                    .foregroundColor(Color.clear)
                }
                guard let newRate = newRates?[coinCode] else { return Image(systemName: "clear")
                    .foregroundColor(Color.clear)
                }
                
                if newRate > previousRate {
                    return  Image(systemName: "arrowtriangle.up.fill")
                        .foregroundColor(Color.green)
                }
                else if previousRate > newRate {
                    return  Image(systemName: "arrowtriangle.down.fill")
                        .foregroundColor(Color.red)
                } else {
                    return Image(systemName: "clear")
                        .foregroundColor(Color.clear)
                }
            }
        }
        return body
    }
    
    private func yesterday() -> String {
        
        var dateComponents = DateComponents()
        dateComponents.setValue(-1, for: .day)
        
        let now = Date()
        let yesterdayDate = Calendar.current.date(byAdding: dateComponents, to: now)
        let yesterdayFull = yesterdayDate?.description
        let yesterday = String(yesterdayFull?.prefix(10) ?? "")
        
        return yesterday
    }
}
