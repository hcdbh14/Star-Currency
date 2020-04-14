import Foundation

public func convertTextToCoin (_ hebrewCoinName: String) -> String {
    
    
    switch hebrewCoinName {
    case NSLocalizedString("Afghanistan", comment: "").lowercased() + " " + NSLocalizedString("Afghan afghani", comment: "").lowercased():
        return "AFN"
    case NSLocalizedString("Albania", comment: "").lowercased() + " " + NSLocalizedString("Albanian lek", comment: "").lowercased():
        return "ALL"
    case NSLocalizedString("Armenia", comment: "").lowercased() + " " + NSLocalizedString("Armenian dram", comment: "").lowercased():
        return "AMD"
    case NSLocalizedString("Angola", comment: "").lowercased() + " " + NSLocalizedString("Angolan kwanza", comment: "").lowercased():
        return "AOA"
    case NSLocalizedString("Azerbaijani", comment: "").lowercased() + " " + NSLocalizedString("Azerbaijani manat", comment: "").lowercased():
        return "AZN"
    case NSLocalizedString("Bosnia and Herzegovina", comment: "").lowercased() + " " + NSLocalizedString("Bosnian Convertible Mark", comment: "").lowercased():
        return "BAM"
    case NSLocalizedString("Barbados", comment: "").lowercased() + " " + NSLocalizedString("Barbados Dollar", comment: "").lowercased():
        return "BBD"
    case NSLocalizedString("Cryptocurrency", comment: "").lowercased() + " " + NSLocalizedString("Bitcoin Cash", comment: "").lowercased():
        return "BCH"
    case NSLocalizedString("Bangladesh", comment: "").lowercased() + " " + NSLocalizedString("Bangladeshi taka", comment: "").lowercased():
        return "BDT"
    case NSLocalizedString("Bahrain", comment: "").lowercased() + " " + NSLocalizedString("Bahraini dinar", comment: "").lowercased():
        return "BHD"
    case NSLocalizedString("Burundi", comment: "").lowercased() + " " + NSLocalizedString("Burundian franc", comment: "").lowercased():
        return "BIF"
    case NSLocalizedString("Brunei", comment: "").lowercased() + " " + NSLocalizedString("Brunei dollar", comment: "").lowercased():
        return "BND"
    case NSLocalizedString("Bolivia", comment: "").lowercased() + " " + NSLocalizedString("Boliviano", comment: "").lowercased():
        return "BOB"
    case NSLocalizedString("Cryptocurrency", comment: "").lowercased() + " " + NSLocalizedString("Bitcoin", comment: "").lowercased():
        return "BTC"
    case NSLocalizedString("Cryptocurrency", comment: "").lowercased() + " " + NSLocalizedString("Bitcoin Gold", comment: "").lowercased():
        return "BTG"
    case NSLocalizedString("Botswana", comment: "").lowercased() + " " + NSLocalizedString("Botswana pula", comment: "").lowercased():
        return "BWP"
    case NSLocalizedString("Belize", comment: "").lowercased() + " " + NSLocalizedString("Belize dollar", comment: "").lowercased():
        return "BZD"
    case NSLocalizedString("Congo", comment: "").lowercased() + " " + NSLocalizedString("Congolese franc", comment: "").lowercased():
        return "CDF"
    case NSLocalizedString("Costa Rica", comment: "").lowercased() + " " + NSLocalizedString("Costa Rican colón", comment: "").lowercased():
        return "CRC"
    case NSLocalizedString("Cuba", comment: "").lowercased() + " " + NSLocalizedString("Cuban convertible peso", comment: "").lowercased():
        return "CUC"
    case NSLocalizedString("Cape Verde", comment: "").lowercased() + " " + NSLocalizedString("Cape Verdean escudo", comment: "").lowercased():
        return "CVE"
    case NSLocalizedString("Cryptocurrency", comment: "").lowercased() + " " + NSLocalizedString("Dash", comment: "").lowercased():
        return "DASH"
    case NSLocalizedString("Djibouti", comment: "").lowercased() + " " + NSLocalizedString("Djiboutian franc", comment: "").lowercased():
        return "DJF"
    case NSLocalizedString("Algeria", comment: "").lowercased() + " " + NSLocalizedString("Algerian dinar", comment: "").lowercased():
        return "DZD"
    case NSLocalizedString("Ethiopia", comment: "").lowercased() + " " + NSLocalizedString("Ethiopian birr", comment: "").lowercased():
        return "ETB"
    case NSLocalizedString("Cryptocurrency", comment: "").lowercased() + " " + NSLocalizedString("Ethereum", comment: "").lowercased():
        return "ETH"
    case NSLocalizedString("Georgia", comment: "").lowercased() + " " + NSLocalizedString("Georgian lari", comment: "").lowercased():
        return "GEL"
    case NSLocalizedString("Honduras", comment: "").lowercased() + " " + NSLocalizedString("Honduran lempira", comment: "").lowercased():
        return "HNL"
    case NSLocalizedString("Haiti", comment: "").lowercased() + " " + NSLocalizedString("Haitian gourde", comment: "").lowercased():
        return "HTG"
    case NSLocalizedString("Jamaica", comment: "").lowercased() + " " + NSLocalizedString("Jamaican dollar", comment: "").lowercased():
        return "JMD"
    case NSLocalizedString("Jordan", comment: "").lowercased() + " " + NSLocalizedString("Jordanian dinar", comment: "").lowercased():
        return "JOD"
    case NSLocalizedString("Kenya", comment: "").lowercased() + " " + NSLocalizedString("Kenyan shilling", comment: "").lowercased():
        return "KES"
    case NSLocalizedString("Kyrgyzstan", comment: "").lowercased() + " " + NSLocalizedString("Kyrgyzstani som", comment: "").lowercased():
        return "KGS"
    case NSLocalizedString("Kuwait", comment: "").lowercased() + " " + NSLocalizedString("Kuwaiti dinar", comment: "").lowercased():
        return "KWD"
    case NSLocalizedString("Laos", comment: "").lowercased() + " " + NSLocalizedString("Lao kip", comment: "").lowercased():
        return "LAK"
    case NSLocalizedString("Sri Lanka", comment: "").lowercased() + " " + NSLocalizedString("Sri Lankan rupee", comment: "").lowercased():
        return "LKR"
    case NSLocalizedString("Cryptocurrency", comment: "").lowercased() + " " + NSLocalizedString("Litecoin", comment: "").lowercased():
        return "LTC"
    case NSLocalizedString("Moldova", comment: "").lowercased() + " " + NSLocalizedString("Moldovan leu", comment: "").lowercased():
        return "MDL"
    case NSLocalizedString("Macedonia", comment: "").lowercased() + " " + NSLocalizedString("Macedonian denar", comment: "").lowercased():
        return "MKD"
    case NSLocalizedString("Myanmar", comment: "").lowercased() + " " + NSLocalizedString("Burmese kyat", comment: "").lowercased():
        return "MMK"
    case NSLocalizedString("Macau", comment: "").lowercased() + " " + NSLocalizedString("Macanese pataca", comment: "").lowercased():
        return "MOP"
    case NSLocalizedString("Mauritius", comment: "").lowercased() + " " + NSLocalizedString("Mauritian rupee", comment: "").lowercased():
        return "MUR"
    case NSLocalizedString("Maldives", comment: "").lowercased() + " " + NSLocalizedString("Maldivian rufiyaa", comment: "").lowercased():
        return "MVR"
    case NSLocalizedString("Nigeria", comment: "").lowercased() + " " + NSLocalizedString("Nigerian naira", comment: "").lowercased():
        return "NGN"
    case NSLocalizedString("Nicaragua", comment: "").lowercased() + " " + NSLocalizedString("Nicaraguan córdoba", comment: "").lowercased():
        return "NIO"
    case NSLocalizedString("Nepal", comment: "").lowercased() + " " + NSLocalizedString("Nepalese rupee", comment: "").lowercased():
        return "NPR"
    case NSLocalizedString("Qatar", comment: "").lowercased() + " " + NSLocalizedString("Qatari Riyal", comment: "").lowercased():
        return "QAR"
    case NSLocalizedString("Serbia", comment: "").lowercased() + " " + NSLocalizedString("Serbian dinar", comment: "").lowercased():
        return "RSD"
    case NSLocalizedString("Seychelles", comment: "").lowercased() + " " + NSLocalizedString("Seychellois rupee", comment: "").lowercased():
        return "SCR"
    case NSLocalizedString("Suriname", comment: "").lowercased() + " " + NSLocalizedString("Suriname Dollar", comment: "").lowercased():
        return "SRD"
    case NSLocalizedString("El Salvador", comment: "").lowercased() + " " + NSLocalizedString("Salvadoran colón", comment: "").lowercased():
        return "SVC"
    case NSLocalizedString("Cryptocurrency", comment: "").lowercased() + " " + NSLocalizedString("Ripple", comment: "").lowercased():
        return "XRP"
        
        
    case NSLocalizedString("Morocco", comment: "").lowercased() + " " + NSLocalizedString("Moroccan dirham", comment: "").lowercased():
        return "AED"
    case NSLocalizedString("Argentina", comment: "").lowercased() + " " + NSLocalizedString("Argentine peso", comment: "").lowercased():
        return "ARS"
    case NSLocalizedString("Australia", comment: "").lowercased() + " " + NSLocalizedString("Australian dollar", comment: "").lowercased():
        return "AUD"
    case NSLocalizedString("Bulgaria", comment: "").lowercased() + " " + NSLocalizedString("Bulgarian lev", comment: "").lowercased():
        return "BGN"
    case NSLocalizedString("Brazil", comment: "").lowercased() + " " + NSLocalizedString("Brazilian real", comment: "").lowercased():
        return "BRL"
    case NSLocalizedString("Bahamas", comment: "").lowercased() + " " + NSLocalizedString("Bahamian dollar", comment: "").lowercased():
        return "BSD"
    case NSLocalizedString("Canada", comment: "").lowercased() + " " + NSLocalizedString("Canadian dollar", comment: "").lowercased():
        return "CAD"
    case NSLocalizedString("Switzerland", comment: "").lowercased() + " " + NSLocalizedString("Swiss franc", comment: "").lowercased():
        return "CHF"
    case NSLocalizedString("Chile", comment: "").lowercased() + " " + NSLocalizedString("Chilean peso", comment: "").lowercased():
        return "CLP"
    case NSLocalizedString("China", comment: "").lowercased() + " " + NSLocalizedString("Renminbi", comment: "").lowercased():
        return "CNY"
    case NSLocalizedString("Colombia", comment: "").lowercased() + " " + NSLocalizedString("Colombian peso", comment: "").lowercased():
        return "COP"
    case NSLocalizedString("Czech", comment: "").lowercased() + " " + NSLocalizedString("Czech koruna", comment: "").lowercased():
        return "CZK"
    case NSLocalizedString("Denmark", comment: "").lowercased() + " " + NSLocalizedString("Danish krone", comment: "").lowercased():
        return "DKK"
    case NSLocalizedString("Dominican-republic", comment: "").lowercased() + " " + NSLocalizedString("Dominican peso", comment: "").lowercased():
        return "DOP"
    case NSLocalizedString("Egypt", comment: "").lowercased() + " " + NSLocalizedString("Egyptian pound", comment: "").lowercased():
        return "EGP"
    case  NSLocalizedString("European Union", comment: "").lowercased() + " " + NSLocalizedString("Euro", comment: "").lowercased():
        return "EUR"
    case NSLocalizedString("Fiji", comment: "").lowercased() + " " + NSLocalizedString("Fijian dollar", comment: "").lowercased():
        return "FJD"
    case NSLocalizedString("United-Kingdom", comment: "").lowercased() + " " + NSLocalizedString("Pound sterling", comment: "").lowercased():
        return "GBP"
    case NSLocalizedString("Guatemala", comment: "").lowercased() + " " + NSLocalizedString("Guatemalan quetzal", comment: "").lowercased():
        return "GTQ"
    case NSLocalizedString("Hong-Kong", comment: "").lowercased() + " " + NSLocalizedString("Hong Kong dollar", comment: "").lowercased():
        return "HKD"
    case NSLocalizedString("Croatia", comment: "").lowercased() + " " + NSLocalizedString("Croatian kuna", comment: "").lowercased():
        return "HRK"
    case NSLocalizedString("Hungary", comment: "").lowercased() + " " + NSLocalizedString("Hungarian forint", comment: "").lowercased():
        return "HUF"
    case NSLocalizedString("Indonesia", comment: "").lowercased() + " " + NSLocalizedString("Indonesian rupiah", comment: "").lowercased():
        return "IDR"
    case NSLocalizedString("Israel", comment: "").lowercased() + " " + NSLocalizedString("Israeli Shekel", comment: "").lowercased():
        return "ILS"
    case NSLocalizedString("India", comment: "").lowercased() + " " + NSLocalizedString("Indian rupee", comment: "").lowercased():
        return "INR"
    case NSLocalizedString("Iceland", comment: "").lowercased() + " " + NSLocalizedString("Icelandic króna", comment: "").lowercased():
        return "ISK"
    case NSLocalizedString("Japan", comment: "").lowercased() + " " + NSLocalizedString("Japanese yen", comment: "").lowercased():
        return "JPY"
    case NSLocalizedString("South-Korea", comment: "").lowercased() + " " + NSLocalizedString("South Korean won", comment: "").lowercased():
        return "KRW"
    case NSLocalizedString("Kazakhstan", comment: "").lowercased() + " " + NSLocalizedString("Kazakhstani tenge", comment: "").lowercased():
        return "KZT"
    case NSLocalizedString("Mexico", comment: "").lowercased() + " " + NSLocalizedString("Mexican peso", comment: "").lowercased():
        return "MXN"
    case NSLocalizedString("Malaysia", comment: "").lowercased() + " " + NSLocalizedString("Malaysian ringgit", comment: "").lowercased():
        return "MYR"
    case NSLocalizedString("Norway", comment: "").lowercased() + " " + NSLocalizedString("Norwegian krone", comment: "").lowercased():
        return "NOK"
    case NSLocalizedString("New-Zealand", comment: "").lowercased() + " " + NSLocalizedString("New Zealand dollar", comment: "").lowercased():
        return "NZD"
    case NSLocalizedString("Panama", comment: "").lowercased() + " " + NSLocalizedString("Panamanian balboa", comment: "").lowercased():
        return "PAB"
    case NSLocalizedString("Peru", comment: "").lowercased() + " " + NSLocalizedString("Sol", comment: "").lowercased():
        return "PEN"
    case NSLocalizedString("Philippines", comment: "").lowercased() + " " + NSLocalizedString("Philippine peso", comment: "").lowercased():
        return "PHP"
    case NSLocalizedString("Pakistan", comment: "").lowercased() + " " + NSLocalizedString("Pakistani rupee", comment: "").lowercased():
        return "PKR"
    case NSLocalizedString("Poland", comment: "").lowercased() + " " + NSLocalizedString("Polish złoty", comment: "").lowercased():
        return "PLN"
    case NSLocalizedString("Paraguay", comment: "").lowercased() + " " + NSLocalizedString("Paraguayan guaraní", comment: "").lowercased():
        return "PYG"
    case NSLocalizedString("Romania", comment: "").lowercased() + " " + NSLocalizedString("Romanian leu", comment: "").lowercased():
        return "RON"
    case NSLocalizedString("Russia", comment: "").lowercased() + " " + NSLocalizedString("Russian Rouble", comment: "").lowercased():
        return "RUB"
    case NSLocalizedString("Saudi-Arabia", comment: "").lowercased() + " " + NSLocalizedString("Saudi riyal", comment: "").lowercased():
        return "SAR"
    case NSLocalizedString("Sweden", comment: "").lowercased() + " " + NSLocalizedString("Swedish krona", comment: "").lowercased():
        return "SEK"
    case NSLocalizedString("Singapore", comment: "").lowercased() + " " + NSLocalizedString("Singapore dollar", comment: "").lowercased():
        return "SGD"
    case NSLocalizedString("Thailand", comment: "").lowercased() + " " + NSLocalizedString("Thai baht", comment: "").lowercased():
        return "THB"
    case NSLocalizedString("Turkey", comment: "").lowercased() + " " + NSLocalizedString("Turkish lira", comment: "").lowercased():
        return "TRY"
    case NSLocalizedString("Taiwan", comment: "").lowercased() + " " + NSLocalizedString("New Taiwan dollar", comment: "").lowercased():
        return "TWD"
    case NSLocalizedString("Ukraine", comment: "").lowercased() + " " + NSLocalizedString("Ukrainian hryvnia", comment: "").lowercased():
        return "UAH"
    case NSLocalizedString("United-States", comment: "").lowercased() + " " + NSLocalizedString("United States Dollar", comment: "").lowercased():
        return "USD"
    case NSLocalizedString("Uruguay", comment: "").lowercased() + " " + NSLocalizedString("Peso Uruguayo", comment: "").lowercased():
        return "UYU"
    case NSLocalizedString("Vietnam", comment: "").lowercased() + " " + NSLocalizedString("Vietnamese dong", comment: "").lowercased():
        return "VND"
    case NSLocalizedString("South-Africa", comment: "").lowercased() + " " + NSLocalizedString("South African rand", comment: "").lowercased():
        return "ZAR"
    default: return hebrewCoinName
    }
}
