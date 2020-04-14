import SwiftUI

private struct arrayIndex  {
    static let left = 0
    static let right = 1
}

private enum Constants: String {
    case plus = "plus"
    case editText = "Edit"
    case finishText = "Done"
    case alertButton = "Got it!"
    case pageTitle = "My Currencies"
    case alertDesc = "using rates from"
    case exchangeArrow = "arrow.right.arrow.left"
    case alertTitle = "Failed to get Updated Rates"
    
    func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

struct Menu: View {
    @State private var triggerAnimation = false
    @State private var showNewCoinPicker = false
    @State private var editButton = Constants.editText.localizedString()
    @State private var showCoinComparison: Bool = false
    @ObservedObject var rates = Rates()
    @EnvironmentObject var mainVM: MainViewModel
    @Environment(\.editMode) var editMode
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .singleLine
        UITableView.appearance().separatorColor = UIColor.gray
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        VStack {
            if self.showCoinComparison  {
                Calculator(showModel: $showCoinComparison, toggle: $triggerAnimation, coinIhave: mainVM.coinIHave.coinCode, coinIwant: mainVM.coinIWant.coinCode)
                    .animation(.spring())
                    .transition(.move(edge: .top))
                    .environment(\.layoutDirection, .leftToRight)
            }
            
            VStack (alignment: .leading, spacing: 0) {
                HStack {
                    Button(editButton) {
                        self.editMode?.wrappedValue = .active == self.editMode?.wrappedValue ? .inactive : .active
                        if self.editButton == Constants.editText.localizedString() {
                            self.editButton = Constants.finishText.localizedString()
                        } else {
                            self.editButton = Constants.editText.localizedString()
                        }
                    }
                    .animation(nil)
                    .padding(.leading, 20)
                    .foregroundColor(Color.orange)
                    
                    Spacer()
                    
                    Button(action: {
                        self.mainVM.coinIHave = Coin(coinCode: Locale.current.currencyCode ?? "")
                        self.mainVM.coinIWant = Coin(coinCode: "")
                        self.showNewCoinPicker = true
                        self.editMode?.wrappedValue = EditMode.inactive
                        self.editButton = Constants.editText.localizedString()
                    }) {
                        Image(systemName: Constants.plus.rawValue)
                            .resizable()
                            .foregroundColor(Color.orange)
                            .frame(width: 20, height: 20, alignment: .trailing)
                            .padding(.leading, 20)
                    }
                    .sheet(isPresented: $showNewCoinPicker) {
                        NewCoinPicker(showModel: self.$showNewCoinPicker)
                            .environmentObject(self.mainVM)
                    }
                }
                .padding(.top, 40)
                .padding(.bottom, 10)
                
                Text(Constants.pageTitle.localizedString())
                    .frame(width: width, alignment: .leading)
                    .font(Font.custom(rubik, size: 30))
                    .padding(.leading, 20)
                    .foregroundColor(Color.white)
                Spacer()
                
                List {
                    ForEach(mainVM.userChosenCoins ?? [], id: \.self) { item in
                        
                        Button(action: {
                            self.mainVM.coinIHave.coinCode = item[arrayIndex.left]
                            self.mainVM.coinIWant.coinCode = item[arrayIndex.right]
                            self.editMode?.wrappedValue = EditMode.inactive
                            self.editButton = Constants.editText.localizedString()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                self.triggerAnimation = true
                            }
                            self.showCoinComparison = true
                        }) {
                            HStack  {
                                VStack (alignment: .leading, spacing: 0) {
                                    HStack {
                                        Coin(coinCode: item[arrayIndex.left]).coinImage
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .cornerRadius(90)
                                        Text(Coin(coinCode: item[arrayIndex.left]).coinCode)
                                            .font(Font.custom(rubik, size: 22))
                                            .foregroundColor(Color("peach"))
                                        
                                        self.rates.returnRateChange(coinCode: item[arrayIndex.left])
                                        Spacer(minLength: 1)
                                    }
                                    Text(Coin(coinCode: item[arrayIndex.left]).coinName)
                                        .font(Font.custom(rubik, size: 16))
                                        .foregroundColor(Color("gray"))
                                }.padding(.leading, 10)
                                
                                Image(systemName: Constants.exchangeArrow.rawValue).resizable()
                                    .frame(width: 20, height: 20)
                                
                                VStack (alignment: .trailing, spacing: 0) {
                                    HStack {
                                        Spacer(minLength: 1)
                                        self.rates.returnRateChange(coinCode: item[1])
                                        Text(Coin(coinCode: item[arrayIndex.right]).coinCode)
                                            .font(Font.custom(rubik, size: 22))
                                            .foregroundColor(Color("red"))
                                        Coin(coinCode: item[arrayIndex.right]).coinImage
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .cornerRadius(90)
                                    }
                                    Text(Coin(coinCode: item[arrayIndex.right]).coinName)
                                        .font(Font.custom(rubik, size: 16))
                                        .foregroundColor(Color("gray"))
                                }.padding(.trailing, 10)
                                    .frame(height: 80)
                            }
                        }.buttonStyle(MenuButtonStyle())
                    }.onDelete(perform: mainVM.delete(at:))
                        .onMove(perform: mainVM.move)
                }
                .environment(\.colorScheme, .dark)
            }
            .animation(Animation.spring())
            .transition(.move(edge: .bottom))
            .onAppear() {
                DispatchQueue.global().async {
                    self.mainVM.firstAppLaunch()
                    if self.mainVM.coinList == [] {
                        self.mainVM.callService()
                        self.rates.callService()
                    }
                }
                DispatchQueue.global().async {
                    self.mainVM.callAd()
                }
            }
        }.frame(width: width, height: height, alignment: .center)
            .background(Image(space).resizable().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all))
            .alert(isPresented: $mainVM.showServiceError) {
                Alert(title: Text(Constants.alertTitle.localizedString()), message: Text("\(returnTextIfDateIsSaved())"), dismissButton: .default(Text(Constants.alertButton.localizedString())))
        }
    }
    private func returnTextIfDateIsSaved() -> String {
        if mainVM.lastUpdated != "" {
            return  "\(Constants.alertDesc.localizedString()) \(mainVM.lastUpdated)"}
        else { return "" }
    }
}



private struct MenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .frame(alignment: .center)
            .background(Color.blue.opacity(0.01))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var mainVM = MainViewModel()
    static var previews: some View {
        Menu().environmentObject(mainVM)
    }
}

