import SwiftUI

public enum CoinRole {
    case iWant
    case iHave
}

private enum Constants: String {
    case moon = "moon"
    case approveText = "Add"
    case closeText = "Close"
    case downArrow = "down-arrow"
    case chooseText = "Choose Currency"
    case chooseTitle = "Choose Currencies to Convert"
    
    func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

struct NewCoinPicker: View {
    @State private var attempts: Int = 0
    @State private var shakeTop = false
    @State private var shakeBottom = false
    @State private var enableButton = false
    @State private var showCoinSelection = false
    @State private var fromOrToCoin: CoinRole?
    @State private var iHaveText = checkIfLocaleCurrencyNotNill()
    @State private var iWantText = Constants.chooseText.localizedString()
    @Binding private var showModel: Bool
    @EnvironmentObject var mainVM: MainViewModel
    
    init(showModel: Binding<Bool>) {
        self._showModel = showModel
        UITableView.appearance().separatorColor = UIColor.orange
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        VStack {
            if hideButtonIfOnIpad() {
                Spacer()
            } else {
                ZStack (alignment: .trailing) {
                    Button(action: {self.showModel = false}) {
                        Text(Constants.closeText.localizedString())
                            .foregroundColor(Color.orange)
                    }
                    .padding(.top, 5)
                    .padding(.leading, 10)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.top, 5)
                .padding(.bottom, -30)
                Spacer()
            }
            Text(Constants.chooseTitle.localizedString())
                .multilineTextAlignment(.center)
                .frame(width: 300, height: 68)
                .font(Font.custom(rubik, size: 24))
                .foregroundColor(Color.white)
            HStack {
                Spacer()
                Spacer()
                Text(iHaveText).foregroundColor(Color.white)
                    .frame(width: 200)
                    .font(Font.custom(rubik, size: 20))
                    .padding(.bottom, -50)
                    .padding(.leading, 60)
                
                self.mainVM.coinIHave.coinImage
                    .frame(width: 60, height: 60)
                    .cornerRadius(60)
                    .addBorder(Color.white, width: 1, cornerRadius: 60)
                    .padding(.bottom, 5)
                    .padding(.trailing, 20)
                
                Spacer()
            }.background(Color.blue.opacity(0.01))
                .accessibility(label: Text("coinIHave"))
                .environment(\.layoutDirection, .leftToRight)
                .onTapGesture {
                    self.showCoinSelection = true
                    self.fromOrToCoin = .iHave
            }
            .modifier(Shake(animatableData: CGFloat(attempts)))
            .animation(.default, value: shakeTop)
            
            line
            
            ZStack{
                Image(Constants.downArrow.rawValue).resizable()
                    .frame(width: 60, height: 50)
                    .opacity(0.8)
                    .padding(.top, 40)
            }
            
            HStack() {
                Spacer()
                Spacer()
                Text (iWantText).foregroundColor(Color.white)
                    .frame(width: 200)
                    .font(Font.custom(rubik, size: 20))
                    .padding(.bottom, -50)
                    .padding(.leading, 60 )
                
                self.mainVM.coinIWant.coinImage
                    .frame(width: 60, height: 60)
                    .cornerRadius(60)
                    .addBorder(Color.white, width: 1, cornerRadius: 90)
                    .padding(.trailing, 20)
                    .environment(\.layoutDirection, .leftToRight)
                
                Spacer()
            }.background(Color.blue.opacity(0.01))
                .accessibility(label: Text("coinIWant"))
                .environment(\.layoutDirection, .leftToRight)
                .onTapGesture {
                    self.showCoinSelection = true
                    self.fromOrToCoin = .iWant
            }
            .modifier(Shake(animatableData: CGFloat(attempts)))
            .animation(.default, value: shakeBottom)
            
            line
            
            Spacer()
            ZStack {
                Text(Constants.approveText.localizedString())
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(Color(melon))
                    .foregroundColor(.white)
                    .opacity(enableButton ? 1 : 0.5)
                    .cornerRadius(20)
                    .shadow(radius: 100)
            }.onTapGesture {
                if self.enableButton {
                    self.showModel = false
                    self.mainVM.save()
                } else {
                    self.attempts += 1
                    self.checkIfEmpty()
                }
            }
            .padding(.bottom, 80)
            .padding(.top, 100)
        }.background(Image(Constants.moon.rawValue).resizable().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $showCoinSelection) {
                CoinSelection(showModel: self.$showCoinSelection, iHaveText: self.$iHaveText, iWantText: self.$iWantText, fromOrToCoin: self.fromOrToCoin ?? .iWant, didOpenFromCalculator: false)
                    .environmentObject(self.mainVM)
                    .onDisappear() {
                        if self.mainVM.coinIHave.coinCode != "" && self.mainVM.coinIWant.coinCode != "" {
                            self.enableButton = true
                        }
                }
        }
    }
    
    private func checkIfEmpty () {
        
        if iHaveText == Constants.chooseText.localizedString() {
            shakeTop.toggle()
        }
        if iWantText == Constants.chooseText.localizedString() {
            shakeBottom.toggle()
        }
    }
    private func hideButtonIfOnIpad() -> Bool {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return false
        case .pad:
            return  true
        default:
            return  false
        }
    }
}


private func checkIfLocaleCurrencyNotNill () -> String {
    guard let locale = Locale.current.currencyCode else { return Constants.chooseText.localizedString()}
    
    if Coin(coinCode: locale).coinName == "" {
        return Constants.chooseText.localizedString()
    } else {
        return Coin(coinCode: locale).coinName
    }
}


private var line: some View {
    VStack {
        Divider()
            .frame(width: width - 50, height: 1)
            .background(Color.orange)
    }
}

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)), y: 0))
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    @State static var staticBool = false
    static var mainVM = MainViewModel()
    static var previews: some View {
        NewCoinPicker(showModel: $staticBool).environmentObject(mainVM)
    }
}

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        return overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(content, lineWidth: width))
    }
}
