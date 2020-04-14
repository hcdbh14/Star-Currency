import SwiftUI

private enum Constants: String {
    case oneText = "1"
    case shareText = "Share"
    case cancelText = "Cancel"
    case readyText = "Ready for share"
    case appIcon = "app-launch-icon"
    case updateText = "Last update :"
    case exchangeArrow = "arrow.right.arrow.left"
    
    func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

struct Share: View {
    private let typedCoin: String
    private let resultCoin: String
    private let lastUpdate: String
    private let typedAmount: String
    private let resultAmount: String
    private let rateDifference: String
    @State private var share = false
    @State private var rect1: CGRect = .zero
    @State private var uiimage: UIImage? = nil
    @Binding private var showModel: Bool
    
    init(showModel: Binding<Bool>, typedCoin: String, resultCoin: String, typedAmount: String, resultAmount: String, lastUpdate: String, rateDifference: String) {
        self.typedCoin = typedCoin
        self.resultCoin = resultCoin
        self.typedAmount = typedAmount
        self.rateDifference = rateDifference
        self.resultAmount = resultAmount
        self.lastUpdate = lastUpdate
        self._showModel = showModel
    }
    
    var body: some View {
        VStack {
            ZStack {
                Button(action: {self.showModel = false}) {
                    Text(Constants.cancelText.localizedString())
                        .foregroundColor(Color.orange)
                }
                .padding(.top, 5)
                .padding(.leading, 15)
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.top, 50)
            .padding(.bottom, -30)
            
            
            Text(Constants.readyText.localizedString())
                .font(Font.custom(rubik, size: 30))
                .foregroundColor(Color.white)
                .padding(.top, 50)
            
            line
            
            Spacer()
            VStack {
                Image(Constants.appIcon.rawValue).resizable()
                    .frame(width: 100, height: 100)
                
                HStack {
                    Spacer()
                    VStack {
                        Text(Coin(coinCode: typedCoin).coinName).foregroundColor(Color(peach)).font(Font.custom(rubik, size: 20))
                            .frame(width: 110)
                            .lineLimit(1)
                            .minimumScaleFactor(0.05)
                        (Coin(coinCode: typedCoin).coinImage).resizable()
                            .frame(width: 32, height: 32)
                            .cornerRadius(30)
                            .addBorder(Color.white, width: 1, cornerRadius: 60)
                        Text(typedAmount).font(Font.custom(rubik, size: 28)).foregroundColor(.white)
                            .frame(width: 120)
                            .lineLimit(1)
                            .minimumScaleFactor(0.05)
                    }.padding(.leading, 40)
                    
                    Spacer()
                    Image(systemName: Constants.exchangeArrow.rawValue).resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.white)
                    Spacer()
                    
                    VStack {
                        Text(Coin(coinCode:resultCoin).coinName).foregroundColor(Color(red)).font(Font.custom(rubik, size: 20))
                            .frame(width: 110)
                            .lineLimit(1)
                            .minimumScaleFactor(0.05)
                        (Coin(coinCode: resultCoin).coinImage).resizable()
                            .frame(width: 32, height: 32)
                            .cornerRadius(30)
                            .addBorder(Color.white, width: 1, cornerRadius: 60)
                        Text(resultAmount).font(Font.custom(rubik, size: 28)).foregroundColor(.white)
                            .frame(width: 120)
                            .lineLimit(1)
                            .minimumScaleFactor(0.05)
                    }.padding(.trailing, 40)
                    Spacer()
                }.frame(width: width, alignment: .center)
                Text(Constants.updateText.localizedString()).foregroundColor(.gray)
                Text("\(lastUpdate)").foregroundColor(.gray)
                Text("\(Constants.oneText.rawValue) \(typedCoin) = \(rateDifference) \(resultCoin)").foregroundColor(.gray)
            }.frame(width: width)
                .padding(.top, 25)
                .padding(.bottom, 25)
                .background(RectGetter(rect: $rect1))
                .sheet(isPresented: $share, onDismiss: {
                    self.share = false
                }, content: {
                    ActivityViewController(activityItems: [self.uiimage!])
                })
                .environment(\.layoutDirection, .leftToRight)
            
            Text(Constants.shareText.localizedString())
                .font(Font.custom(rubik, size: 20))
                .frame(width: 200, height: 50, alignment: .center)
                .background(Color(melon))
                .foregroundColor(.black)
                .opacity(0.8)
                .cornerRadius(20)
                .shadow(radius: 100)
                .padding(50)
                .onTapGesture {
                    self.uiimage = UIApplication.shared.windows[0].self.asImage(rect: self.rect1)
                    self.share = true
            }
            Spacer()
        }.frame(width: width, height: height)
            .background(Color(ebony))
    }
    
    private var line: some View {
        VStack {
            Divider()
                .frame(width: width, height: 0.5)
                .background(Color.orange)
        }
    }
}

struct Share_Previews: PreviewProvider {
    static let typedCoin = "ILS"
    static let resultCoin = "USD"
    static let typedAmount = "100"
    static let resultAmount = "28.9"
    static let rateDifference = "0.29"
    static let lastUpdate = "2020-02-29 10:52"
    @State static var staticBool = true
    static var previews: some View {
        Share(showModel: $staticBool, typedCoin: typedCoin, resultCoin: resultCoin, typedAmount: typedAmount, resultAmount: resultAmount, lastUpdate: lastUpdate, rateDifference: rateDifference)
    }
}

struct RectGetter: View {
    @Binding var rect: CGRect
    
    var body: some View {
        GeometryReader { proxy in
            self.createView(proxy: proxy)
        }
    }
    
    func createView(proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = proxy.frame(in: .global)
        }
        
        return Rectangle().fill(Color.clear)
    }
}

extension UIView {
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

struct ActivityViewController: UIViewControllerRepresentable {
    
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
}
