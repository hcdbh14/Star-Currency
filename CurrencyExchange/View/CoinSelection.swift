import SwiftUI

public struct MyButtonStyle: ButtonStyle {
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .frame(width: width, alignment: .leading)
            .background(Color(black))
    }
}

private enum Constants: String {
    case cancelText = "Cancel"
    case placeholderText = "Search"
    case closeAlertText = "Got it!"
    case xCircle = "xmark.circle.fill"
    case magnifyglass = "magnifyingglass"
    case alertTitle = "Currencies Unlock"
    case alertDesc = "All currencies unlocked for 1 day. enjoy :)"
    
    func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

struct CoinSelection: View {
    
    private let fromOrToCoin: CoinRole
    private let didOpenFromCalculator: Bool
    @State private var searchText = ""
    @State private var showOfferModel = false
    @Binding private var showModel: Bool
    @Binding private var iHaveText: String
    @Binding private var iWantText: String
    @EnvironmentObject var mainVM: MainViewModel
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    
    init(showModel: Binding<Bool>,iHaveText: Binding<String>, iWantText: Binding<String>, fromOrToCoin: CoinRole, didOpenFromCalculator: Bool) {
        self._showModel = showModel
        self._iHaveText = iHaveText
        self._iWantText = iWantText
        self.fromOrToCoin = fromOrToCoin
        self.didOpenFromCalculator = didOpenFromCalculator
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: Constants.magnifyglass.rawValue)
                    if colorScheme == .light {
                        TextField(Constants.placeholderText.localizedString(), text: $searchText)
                            .colorInvert()
                    } else {
                        TextField(Constants.placeholderText.localizedString(), text: $searchText)
                    }
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: Constants.xCircle.rawValue).opacity(searchText == "" ? 0 : 1)
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(Color.gray)
                .background(Color(darker))
                .cornerRadius(10.0)
                
                Button(Constants.cancelText.localizedString()) {
                    UIApplication.shared.endEditing(true)
                    self.showModel = false
                }
                .foregroundColor(Color.orange)
            }
            .padding(.horizontal)
            .background(Color(black))
            
            List {
                ForEach(self.mainVM.coinNames.filter{$0.contains(self.searchText.lowercased()) || self.searchText == ""}, id:\.self) {
                    searchText in
                    Button(action: {
                        let chosenCoin = Coin(coinCode: convertTextToCoin(searchText))
                        if chosenCoin.premium ?? false {
                            //                            self.showOfferModel = true
                            self.mainVM.startAd()
                            
                        } else {
                            
                            switch self.fromOrToCoin {
                            case .iHave:
                                if self.didOpenFromCalculator {
                                    self.mainVM.replace(newCoin: chosenCoin.coinCode, fromOrTo: .iHave)
                                }
                                self.mainVM.coinIHave.coinCode = chosenCoin.coinCode
                                self.iHaveText = self.mainVM.coinIHave.coinName
                                self.showModel = false
                                
                            case .iWant:
                                if self.didOpenFromCalculator {
                                    self.mainVM.replace(newCoin: chosenCoin.coinCode, fromOrTo: .iWant)
                                }
                                self.mainVM.coinIWant.coinCode = chosenCoin.coinCode
                                self.iWantText = self.mainVM.coinIWant.coinName
                                self.showModel = false
                            }
                        }})
                    {
                        HStack {
                            Coin(coinCode: convertTextToCoin(searchText)).coinImage.resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(90)
                            
                            VStack (alignment: .leading) {
                                Text(Coin(coinCode: convertTextToCoin(searchText)).coinName)
                                    .foregroundColor(Color.white)
                                    .font(Font.custom(rubik, size: 22))
                                Text(Coin(coinCode: convertTextToCoin(searchText)).coinCountry)
                                    .foregroundColor(Color.gray)
                                    .font(Font.custom(rubik, size: 18))
                            }
                            if Coin(coinCode: convertTextToCoin(searchText)).premium ?? false  && self.mainVM.didWatchAd == false {
                                Spacer()
                                Image(systemName: "lock.fill").foregroundColor(.orange)
                                    .padding(.trailing, self.paddingBasedOnInterface())
                            }
                        }
                    }.buttonStyle(MyButtonStyle())
                        .animation(Animation.easeIn)
                        .accessibility(label: Text(Coin(coinCode: convertTextToCoin(searchText)).coinName))
                }
            }
        }
        .environment(\.defaultMinListRowHeight, 80)
        .background(Color(black))
        .edgesIgnoringSafeArea(.bottom)
        .animation(Animation.easeInOut)
        .resignKeyboardOnDragGesture()
        .alert(isPresented: $mainVM.didWatchAd) {
            Alert(title: Text(Constants.alertTitle.localizedString()), message: Text(Constants.alertDesc.localizedString()), dismissButton: .default(Text(Constants.closeAlertText.localizedString())))
        }
    }
    
    private func paddingBasedOnInterface() -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return 50
        case .pad:
            return  400
        default:
            return  50
        }
    }
}

struct CoinSelection_Previews: PreviewProvider {
    @State static var staticBool = false
    @State static var staticText = ""
    static var mainVM = MainViewModel()
    static var previews: some View {
        CoinSelection(showModel: $staticBool, iHaveText: $staticText, iWantText: $staticText , fromOrToCoin: .iWant, didOpenFromCalculator: false).environmentObject(mainVM)
    }
}

//MARK: Search Bar Extension
extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
