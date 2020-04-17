import Foundation

public enum Symbol: String {
    case plus = "+"
    case minus = "-"
    case multiply = "x"
    case divide = "/"
    case none = ""
}

class Math: ObservableObject {
    
    var didType = false
    var mathNum = "0"
    var isTyping = false
    var baseValue: Double?
    var coinValue: Double?
    var symbol = Symbol.none
    var previousSymbol = Symbol.none
    var previousNum = "0"
    var changedOpretorFlag = false
    var operationCount = 0
    @Published var topCalculatorNum = "0"
    @Published var bottomResultnum = "0"
    
    init (coinIhave: String, coinIwant: String) {
        self.baseValue = newRates?[coinIhave]
        self.coinValue = newRates?[coinIwant]
    }
    
    
    
    
    func addDecimalPoint() {
        if topCalculatorNum.contains(".") {
            return
        } else {
            topCalculatorNum = topCalculatorNum + "."
            isTyping = true
        }
    }
    
    func addNum(num: String) {
        didType = true
        if isTyping {
            var addedNum = (topCalculatorNum + num)
            if topCalculatorNum.contains(",") {
                addedNum = addedNum.replacingOccurrences(of: ",", with: "")
            }
            let newNum = Double(addedNum)
            topCalculatorNum = newNum?.addComma() ?? ""
            
        } else {
            topCalculatorNum = num
            isTyping = true
        }
        updateComparedNum()
    }
    
    func addZero() {
        if topCalculatorNum == "0" {
            return
        }
        didType = true
        if isTyping {
            
            var addedNum = (topCalculatorNum + "0")
            if topCalculatorNum.contains(",") {
                addedNum = addedNum.replacingOccurrences(of: ",", with: "")
            }
            let newNum = Double(addedNum)
            topCalculatorNum = newNum?.addComma() ?? ""
            
        } else {
            topCalculatorNum = "0"
            isTyping = true
        }
        updateComparedNum()
    }
    
    func remove() {
        if topCalculatorNum == "0" {
            return
        } else if topCalculatorNum.count == 1 {
            topCalculatorNum = "0"
        } else {
            topCalculatorNum.removeLast()
            var stringNum = topCalculatorNum
            if stringNum.contains(",") {
                stringNum = stringNum.replacingOccurrences(of: ",", with: "")
            }
            guard let num = Double(stringNum) else { return }
            topCalculatorNum = num.addComma()
            isTyping = true
        }
        updateComparedNum()
    }
    
    func clear() {
        previousNum = "0"
        topCalculatorNum = "0"
        bottomResultnum = "0"
        previousNum = "0"
        isTyping = false
        operationCount = 0
        previousSymbol = .none
        changedOpretorFlag = false
    }
    
    func prepareOperation(_ mathSymbol: Symbol) {
        if didType {
            if operationCount < 1 {
                if previousSymbol != mathSymbol || previousSymbol == .none {
                    mathNum = topCalculatorNum
                    symbol = mathSymbol
                    isTyping = false
                    operationCount += 1
                } else {
                    mathNum = previousNum
                    symbol = mathSymbol
                    isTyping = false
                    performOperation()
                    operationCount += 1
                }
            } else {
                if previousSymbol != mathSymbol { changedOpretorFlag = true }
                if previousSymbol == mathSymbol || changedOpretorFlag == false {
                    symbol = mathSymbol
                    isTyping = false
                    performOperation()
                    previousNum = topCalculatorNum
                    mathNum = previousNum
                    operationCount += 1
                } else {
                    performOperation()
                    mathNum = topCalculatorNum
                    symbol = mathSymbol
                    isTyping = false
                    operationCount += 1
                    changedOpretorFlag = false
                }
            }
        }
        previousSymbol = mathSymbol
    }
    
    func performOperation() {
        convertToDouble()
        calculate()
        updateComparedNum()
        previousNum = "0"
        isTyping = false
        didType = false
    }
    
    private func convertToDouble() {
        topCalculatorNum = topCalculatorNum.replacingOccurrences(of: ",", with: "")
        mathNum = mathNum.replacingOccurrences(of: ",", with: "")
    }
    
    private func updateComparedNum() {
        var typedNum = topCalculatorNum
        if typedNum.contains(",") {
            typedNum = typedNum.replacingOccurrences(of: ",", with: "")
        }
        guard let num = Double(typedNum) else { return }
        var newValue = num / (baseValue ?? 0)
        newValue = newValue * (coinValue ?? 0)
        bottomResultnum = newValue.addComma()
    }
    
    func coinValueText() -> String {
        return ((coinValue ?? 0) / (baseValue ?? 0)).removeZerosFromEnd()
    }
    
    private func calculate() {
        var result: Double
        guard let firstNum = Double(mathNum) else { return }
        guard let secondNum = Double(topCalculatorNum) else { return }
        switch self.symbol {
        case .plus:
            result = firstNum + secondNum
            if floor(result) == result {
                let wholeNumber = result.removeZerosFromEnd()
                self.topCalculatorNum = String(wholeNumber)
            } else {
                result = Double(round(1000 * result)/1000)
                self.topCalculatorNum = String(result)
            }
            
        case .minus:
            result = firstNum - secondNum
            if floor(result) == result {
                let wholeNumber = result.removeZerosFromEnd()
                self.topCalculatorNum = String(wholeNumber)
            } else {
                result = Double(round(1000 * result)/1000)
                self.topCalculatorNum = String(result)
            }
            
        case .multiply:
            result = firstNum * secondNum
            if floor(result) == result {
                let wholeNumber = result.removeZerosFromEnd()
                self.topCalculatorNum = String(wholeNumber)
            } else {
                result = Double(round(1000 * result)/1000)
                self.topCalculatorNum = String(result)
            }
            
        case .divide:
            result = firstNum / secondNum
            if floor(result) == result {
                let wholeNumber = result.removeZerosFromEnd()
                self.topCalculatorNum = String(wholeNumber)
            } else {
                result = Double(round(1000 * result)/1000)
                self.topCalculatorNum = String(result)
            }
        case .none:
            return
        }
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
        formatter.maximumFractionDigits = 4
        formatter.numberStyle = .decimal
        
        return String(formatter.string(from: number) ?? "")
    }
}
