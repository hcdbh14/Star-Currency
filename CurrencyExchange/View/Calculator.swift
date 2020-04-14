import SwiftUI
import AVKit

private struct Constants {
    static let clear = "C"
    static let zero = "0"
    static let one = "1"
    static let two = "2"
    static let three = "3"
    static let four = "4"
    static let five = "5"
    static let six = "6"
    static let seven = "7"
    static let eight = "8"
    static let nine = "9"
    static let decimal = "."
    static let plus = "plus"
    static let minus = "minus"
    static let equal = "equal"
    static let divide = "divide"
    static let multiply = "multiply"
    static let arrowLeft = "chevron.left"
    static let switchArrow = "arrow.up.arrow.down"
    static let systemIconRefresh = "arrow.clockwise"
    static let systemIconLeft = "chevron.compact.left"
    static let systemShareIcon = "square.and.arrow.up"
    static let systemIconRight = "chevron.compact.right"
    static let systemSound: SystemSoundID = 1104
}

private enum LocalizedConstants: String {
    case backText = "Back"
    
    func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

private enum ActiveSheet {
    case change, share
}

struct Calculator: View {
    @State private var activeSheet: ActiveSheet = .change
    @State private var staticText = ""
    @State private var isRefreshing = false
    @State private var fromOrToCoin: CoinRole?
    @State private var togglePopOver = false
    @Binding var showCoinComparison: Bool
    @Binding var triggerAnimation: Bool
    @ObservedObject var math: Math
    @EnvironmentObject var mainVM: MainViewModel
    
    init (showModel: Binding<Bool>, toggle: Binding<Bool>, coinIhave: String, coinIwant: String) {
        self._showCoinComparison = showModel
        self._triggerAnimation = toggle
        UITableView.appearance().showsVerticalScrollIndicator = false
        self.math = Math(coinIhave: coinIhave, coinIwant: coinIwant)
    }
    
    var body: some View {
        VStack {
            if triggerAnimation {
                VStack {
                    HStack {
                        Spacer()
                        Button(LocalizedConstants.backText.localizedString()) {
                            self.triggerAnimation = false
                            self.showCoinComparison = false
                        }
                        .frame(width: width, alignment: .trailing)
                        .foregroundColor(Color.orange)
                        .padding(.top, height / 8)
                        .padding(.trailing, 25)
                        .padding(.bottom, 5)
                    }
                    HStack {
                        VStack {
                            Button(action: {
                                self.fromOrToCoin = .iHave
                                self.activeSheet = .change
                                self.togglePopOver = true
                            }) {
                                Coin(coinCode: mainVM.coinIHave.coinCode).coinImage.resizable()
                                    .frame(width: 32, height: 32)
                                    .cornerRadius(30)
                                    .addBorder(Color.white, width: 1, cornerRadius: 60)
                            }
                            
                            Text(mainVM.coinIHave.coinCode).foregroundColor(Color("peach"))
                                .font(Font.custom(rubik, size: 18))
                                .animation(.default)
                            
                        }.padding(.leading, 30)
                        Spacer()
                        
                        Text(math.calculatorNum).foregroundColor(Color.white)
                            .frame(width: width / 1.4, alignment: .trailing)
                            .font(Font.custom(rubik, size: 30))
                            .padding(.trailing, 25)
                            .lineLimit(1)
                            .minimumScaleFactor(0.05)
                            .animation(.default)
                    }.frame(height: height / 11)
                        .environment(\.layoutDirection, .leftToRight)
                    line
                    HStack {
                        VStack {
                            Button(action: {
                                self.fromOrToCoin = .iWant
                                self.activeSheet = .change
                                self.togglePopOver = true
                            }) {
                                Coin(coinCode: mainVM.coinIWant.coinCode).coinImage.resizable()
                                    .frame(width: 32, height: 32)
                                    .cornerRadius(30)
                                    .addBorder(Color.white, width: 1, cornerRadius: 60)
                            }
                            
                            Text(mainVM.coinIWant.coinCode).foregroundColor(Color("red"))
                                .font(Font.custom(rubik, size: 18))
                                .animation(.default)
                                .padding(.bottom, 20)
                            
                        }.padding(.leading, 30)
                        Spacer()
                        
                        Text(math.comparedNum).foregroundColor(Color.white)
                            .frame(width: width / 1.4, alignment: .trailing)
                            .font(Font.custom(rubik, size: 30))
                            .padding(.bottom, 20)
                            .padding(.trailing, 25)
                            .lineLimit(1)
                            .minimumScaleFactor(0.05)
                            .animation(.default)
                    }.frame(height: height / 11)
                        .padding(.top, 10)
                        .environment(\.layoutDirection, .leftToRight)
                }
                .frame(alignment: .bottom)
                .background(Color.black.opacity(0.2))
                .animation(Animation.spring().delay(triggerAnimation ? 0 : 0.2))
                .transition(.move(edge: .top))
                
                VStack {
                    HStack {
                        Button(Constants.clear) {
                            self.math.clear()
                            AudioServicesPlaySystemSound(Constants.systemSound)
                        }
                        .buttonStyle(calculatorButtonStyle())
                        .padding(.leading, -6)
                        
                        Button(action: {
                            self.math.remove()
                            AudioServicesPlaySystemSound(Constants.systemSound)
                        }) { Image(systemName: Constants.arrowLeft)
                        }.buttonStyle(calculatorButtonStyle())
                            .padding(.leading, -6)
                        
                        Button(action: {
                            self.switchCoins()
                            AudioServicesPlaySystemSound(Constants.systemSound)
                        }) { Image(systemName: Constants.switchArrow)
                        }
                        .font(Font.custom(rubik, size: 18 ))
                        .buttonStyle(calculatorButtonStyle())
                        .padding(.leading, -6)
                        
                        Button(action: {
                            self.math.prepareOperation(Symbol.divide)
                            AudioServicesPlaySystemSound(Constants.systemSound)
                        }) { Image(systemName: Constants.divide)
                        }.buttonStyle(sideCalculatorButtonStyle())
                            .font(Font.custom(rubik, size: 22))
                            .padding(.leading, -6)
                    }
                    .padding(.top, -20)
                    .padding(.bottom, -11)
                    
                    HStack {
                        Button(Constants.seven) {
                            self.math.addNum(num: Constants.seven)
                            AudioServicesPlaySystemSound(Constants.systemSound)
                            
                        }
                        .buttonStyle(calculatorButtonStyle())
                        .padding(.leading, -6)
                        
                        Button(Constants.eight) {
                            self.math.addNum(num: Constants.eight)
                            AudioServicesPlaySystemSound(Constants.systemSound)
                        }
                        .buttonStyle(calculatorButtonStyle())
                        .padding(.leading, -6)
                        
                        Button(Constants.nine) {
                            self.math.addNum(num: Constants.nine)
                            AudioServicesPlaySystemSound(Constants.systemSound)
                        }
                        .buttonStyle(calculatorButtonStyle())
                        .padding(.leading, -6)
                        
                        Button(action: {
                            self.math.prepareOperation(Symbol.multiply)
                            AudioServicesPlaySystemSound(Constants.systemSound)
                        }) { Image(systemName: Constants.multiply)
                        }
                        .font(Font.custom(rubik, size: 20))
                        .buttonStyle(sideCalculatorButtonStyle())
                        .padding(.leading, -6)
                    }
                    .padding(.top, -2)
                    .padding(.bottom, -10.5)
                    
                    HStack {
                        Button(Constants.four) {
                            self.math.addNum(num: Constants.four)
                            AudioServicesPlaySystemSound(Constants.systemSound)
                        }
                        .buttonStyle(calculatorButtonStyle())
                        .padding(.leading, -6)
                        
                        Button(Constants.five) {
                            self.math.addNum(num: Constants.five)
                            AudioServicesPlaySystemSound(Constants.systemSound)
                        }
                        .buttonStyle(calculatorButtonStyle())
                        .padding(.leading, -6)
                        
                        Button(Constants.six) {
                            self.math.addNum(num: Constants.six)
                            AudioServicesPlaySystemSound(Constants.systemSound)
                        }
                        .buttonStyle(calculatorButtonStyle())
                        .padding(.leading, -6)
                        
                        Button(action: {
                            self.math.prepareOperation(Symbol.minus)
                            AudioServicesPlaySystemSound(Constants.systemSound)
                        }) { Image(systemName: Constants.minus)
                        }
                        .font(Font.custom(rubik, size: 20))
                        .buttonStyle(sideCalculatorButtonStyle())
                        .padding(.leading, -6)
                        
                    }
                    .padding(.top, -2)
                    .padding(.bottom, -10.5)
                    
                    HStack {
                        Button(Constants.one) {
                            self.math.addNum(num: Constants.one)
                            AudioServicesPlaySystemSound(Constants.systemSound)
                        }
                        .buttonStyle(calculatorButtonStyle())
                        .padding(.leading, -6)
                        
                        Button(Constants.two) {
                            self.math.addNum(num: Constants.two)
                            AudioServicesPlaySystemSound(Constants.systemSound)
                        }
                        .buttonStyle(calculatorButtonStyle())
                        .padding(.leading, -6)
                        
                        Button(Constants.three) {
                            self.math.addNum(num: Constants.three)
                            AudioServicesPlaySystemSound(Constants.systemSound)
                        }
                        .buttonStyle(calculatorButtonStyle())
                        .padding(.leading, -6)
                        
                        Button(action: {
                            self.math.prepareOperation(Symbol.plus)
                            AudioServicesPlaySystemSound(Constants.systemSound)
                        }) { Image(systemName: Constants.plus)
                        }
                        .font(Font.custom(rubik, size: 20))
                        .buttonStyle(sideCalculatorButtonStyle())
                        .padding(.leading, -6)
                    }
                    .padding(.top, -2)
                    .padding(.bottom, -10.5)
                    
                    HStack {
                        Button(Constants.zero) {
                            self.math.addZero()
                            AudioServicesPlaySystemSound(Constants.systemSound)
                        }
                        .buttonStyle(zeroButtonStyle())
                            
                        .padding(.leading, -4.5)
                        
                        Button(Constants.decimal) {
                            self.math.addDecimalPoint()
                            AudioServicesPlaySystemSound(Constants.systemSound)
                        }
                        .buttonStyle(calculatorButtonStyle())
                        .padding(.leading, -6)
                        
                        Button(action: {
                            self.math.performOperation()
                            AudioServicesPlaySystemSound(Constants.systemSound)
                        }) { Image(systemName: Constants.equal)
                        }
                        .font(Font.custom(rubik, size: 20))
                        .buttonStyle(sideCalculatorButtonStyle())
                        .padding(.leading, -6)
                        
                    }
                    .padding(.top, -2)
                    .padding(.bottom, -10.5)
                }
                .animation(Animation.spring().delay(triggerAnimation ? 0 : 0.4))
                .transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .move(edge: .trailing)), removal: .move(edge: .trailing)))
                .environment(\.layoutDirection, .leftToRight)
                .frame(width: width + 20)
                
                HStack  {
                    if isRefreshing {
                        
                        ActivityIndicator(isAnimating: true)
                            .configure { $0.color = .orange }
                            .padding(.leading, 10)
                    } else {
                        Button(action: {
                            self.mainVM.callService()
                            self.isRefreshing = true
                            self.playLoader()
                        }) {
                            Image(systemName: Constants.systemIconRefresh)
                                .foregroundColor(Color.orange)
                                .padding(.leading, 15)
                        }
                    }
                    Spacer()
                    VStack {
                        Text(mainVM.lastUpdated).foregroundColor(Color.green)
                        Text("\(Constants.one) \(mainVM.coinIHave.coinCode) = \(math.coinValueText()) \(mainVM.coinIWant.coinCode)").foregroundColor(Color.gray)
                    }
                    Spacer()
                    Button(action: {
                        self.activeSheet = .share
                        self.togglePopOver = true
                    }) {
                        Image(systemName: Constants.systemShareIcon)
                            .foregroundColor(Color.orange)
                    }
                    .padding(.trailing, 15)
                }
                .frame(width: width, height: height / 12)
                .animation(Animation.spring().delay(triggerAnimation ? 0 : 0.4))
                .transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .move(edge: .trailing)), removal: .move(edge: .trailing)))
                .environment(\.layoutDirection, .leftToRight)
                .sheet(isPresented: $togglePopOver) {
                    if self.activeSheet == .change {
                        CoinSelection(showModel: self.$togglePopOver, iHaveText: self.$staticText, iWantText: self.$staticText, fromOrToCoin: self.fromOrToCoin ?? .iWant, didOpenFromCalculator: true)
                            .environmentObject(self.mainVM)
                    } else {
                        self.initShareModel()
                    }
                }
            }
        }
        .frame(width: width, height: height, alignment: .top)
        .background(Image(space).resizable().aspectRatio(contentMode: .fill))
    }
    
    private func playLoader() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            DispatchQueue.main.async {
                self.isRefreshing = false
            }
        }
    }
    
    private func switchCoins() {
        let tempTopValue = mainVM.coinIHave.coinCode
        let tempBotValue = mainVM.coinIWant.coinCode
        mainVM.coinIHave.coinCode = tempBotValue
        mainVM.coinIWant.coinCode = tempTopValue
    }
    
    private func initShareModel() -> some View {
        return Share(showModel: self.$togglePopOver, typedCoin: self.mainVM.coinIHave.coinCode, resultCoin: self.mainVM.coinIWant.coinCode, typedAmount: self.math.calculatorNum, resultAmount: self.math.comparedNum, lastUpdate:self.mainVM.lastUpdated, rateDifference: self.math.coinValueText())
    }
}


private struct calculatorButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width / 4, height: height / 9)
            .font(Font.custom(rubik, size: 23))
            .foregroundColor(Color.orange)
            .background(configuration.isPressed ? Color.gray : Color(darkBlue))
    }
}

private struct sideCalculatorButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width / 4, height: height / 9)
            .foregroundColor(Color.orange)
            .background(configuration.isPressed ? Color.gray : Color(darkBlue))
    }
}

private struct zeroButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width / 2, height: height / 9)
            .font(Font.custom(rubik, size: 23))
            .foregroundColor(Color.orange)
            .background(configuration.isPressed ? Color.gray : Color(darkBlue))
    }
}

private var line: some View {
    VStack {
        Divider()
            .frame(width: width, height: 0.5)
            .background(Color.gray)
    }
}


struct CoinComparison_Previews: PreviewProvider {
    @State static var staticBool = true
    static var previews: some View {
        Calculator(showModel: $staticBool, toggle: $staticBool, coinIhave: "ILS", coinIwant: "ILS")
    }
}


struct ActivityIndicator: UIViewRepresentable {
    
    typealias UIView = UIActivityIndicatorView
    var isAnimating: Bool
    var configuration = { (indicator: UIView) in }
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView { UIView() }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        configuration(uiView)
    }
}

extension View where Self == ActivityIndicator {
    func configure(_ configuration: @escaping (Self.UIView)->Void) -> Self {
        Self.init(isAnimating: self.isAnimating, configuration: configuration)
    }
}
