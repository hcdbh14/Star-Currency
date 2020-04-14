import Foundation

public enum Symbol: String {
    case plus = "+"
    case minus = "-"
    case multiply = "x"
    case divide = "/"
    case none = ""
}

class Math: ObservableObject {
    
    var mathNum = "0"
    var isTyping = false
    var baseValue: Double?
    var coinValue: Double?
    var symbol = Symbol.none
    @Published var calculatorNum = "0"
    @Published var comparedNum = "0"
    
    init (coinIhave: String, coinIwant: String) {
        self.baseValue = newRates?[coinIhave]
        self.coinValue = newRates?[coinIwant]
    }
    
    
    func addNum(num: String) {
        if isTyping {
            var addedNum = (calculatorNum + num)
            if calculatorNum.contains(",") {
                addedNum = addedNum.replacingOccurrences(of: ",", with: "")
            }
            let newNum = Double(addedNum)
            calculatorNum = newNum?.addComma() ?? ""
            
        } else {
            calculatorNum = num
            isTyping = true
        }
        updateComparedNum()
    }
    
    func addDecimalPoint() {
        if calculatorNum.contains(".") {
            return
        } else {
            calculatorNum = calculatorNum + "."
            isTyping = true
        }
    }
    
    func addZero() {
        if calculatorNum == "0" {
            return
        } else {
            var stringNum = calculatorNum + "0"
            if stringNum.contains(",") {
                stringNum = stringNum.replacingOccurrences(of: ",", with: "")
            }
            guard let num = Double(stringNum) else { return }
            calculatorNum = num.addComma()
            isTyping = true
        }
        updateComparedNum()
    }
    
    func remove() {
        if calculatorNum == "0" {
            return
        } else if calculatorNum.count == 1 {
            calculatorNum = "0"
        } else {
            calculatorNum.removeLast()
            var stringNum = calculatorNum
            if stringNum.contains(",") {
                stringNum = stringNum.replacingOccurrences(of: ",", with: "")
            }
            guard let num = Double(stringNum) else { return }
            calculatorNum = num.addComma()
            isTyping = true
        }
        updateComparedNum()
    }
    
    func clear() {
        calculatorNum = "0"
        comparedNum = "0"
        isTyping = false
    }
    
    func prepareOperation(_ mathSymbol: Symbol) {
        mathNum = calculatorNum
        symbol = mathSymbol
        isTyping = false
    }
    
    func performOperation() {
        
        var result: Double
        convertToDouble()
        guard let firstNum = Double(mathNum) else { return }
        guard let secondNum = Double(calculatorNum) else { return }
        
        switch self.symbol {
        case .plus:
            result = firstNum + secondNum
            if floor(result) == result {
                let wholeNumber = result.removeZerosFromEnd()
                self.calculatorNum = String(wholeNumber)
            } else {
                result = Double(round(1000 * result)/1000)
                self.calculatorNum = String(result)
            }
            
        case .minus:
            result = firstNum - secondNum
            if floor(result) == result {
                let wholeNumber = result.removeZerosFromEnd()
                self.calculatorNum = String(wholeNumber)
            } else {
                result = Double(round(1000 * result)/1000)
                self.calculatorNum = String(result)
            }
            
        case .multiply:
            result = firstNum * secondNum
            if floor(result) == result {
                let wholeNumber = result.removeZerosFromEnd()
                self.calculatorNum = String(wholeNumber)
            } else {
                result = Double(round(1000 * result)/1000)
                self.calculatorNum = String(result)
            }
            
        case .divide:
            result = firstNum / secondNum
            if floor(result) == result {
                let wholeNumber = result.removeZerosFromEnd()
                self.calculatorNum = String(wholeNumber)
            } else {
                result = Double(round(1000 * result)/1000)
                self.calculatorNum = String(result)
            }
            
        case .none:
            return
        }
        updateComparedNum()
        self.symbol = .none
    }
    
    private func convertToDouble() {
        calculatorNum = calculatorNum.replacingOccurrences(of: ",", with: "")
        mathNum = mathNum.replacingOccurrences(of: ",", with: "")
    }
    
    private func updateComparedNum() {
        var typedNum = calculatorNum
        if typedNum.contains(",") {
            typedNum = typedNum.replacingOccurrences(of: ",", with: "")
        }
        guard let num = Double(typedNum) else { return }
        var newValue = num / (baseValue ?? 0)
        newValue = newValue * (coinValue ?? 0)
        comparedNum = newValue.addComma()
    }
    
    func coinValueText() -> String {
            return ((coinValue ?? 0) / (baseValue ?? 0)).removeZerosFromEnd()
    }
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        
        return String(formatter.string(from: number) ?? "")
    }
    
    func addComma() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        
        return String(formatter.string(from: number) ?? "")
    }
}
