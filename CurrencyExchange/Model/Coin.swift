import SwiftUI

struct CoinGroup: Decodable, Identifiable {
    let id = UUID()
    let rates: [String:Double]?
}

struct Coin: Identifiable, Hashable {
    let id = UUID()
    var premium: Bool?  {
        get {
            if UserDefaults.standard.integer(forKey: "unlockType") <= 1 {
                
                if didTwentyFourHoursPass {
                    switch coinCode {
                    case "AFN": return true
                    case "ALL": return true
                    case "AMD": return true
                    case "AOA": return true
                    case "AZN": return true
                    case "BAM": return true
                    case "BBD": return true
                    case "BCH": return true
                    case "BDT": return true
                    case "BHD": return true
                    case "BIF": return true
                    case "BND": return true
                    case "BOB": return true
                    case "BTC": return true
                    case "BTG": return true
                    case "BWP": return true
                    case "BZD": return true
                    case "CDF": return true
                    case "CRC": return true
                    case "CUC": return true
                    case "CVE": return true
                    case "DASH": return true
                    case "DJF": return true
                    case "DZD": return true
                    case "ETB": return true
                    case "ETH": return true
                    case "GEL": return true
                    case "HNL": return true
                    case "HTG": return true
                    case "JMD": return true
                    case "JOD": return true
                    case "KES": return true
                    case "KGS": return true
                    case "KWD": return true
                    case "LAK": return true
                    case "LKR": return true
                    case "LTC": return true
                    case "MDL": return true
                    case "MKD": return true
                    case "MMK": return true
                    case "MOP": return true
                    case "MUR": return true
                    case "MVR": return true
                    case "NGN": return true
                    case "NIO": return true
                    case "NPR": return true
                    case "QAR": return true
                    case "RSD": return true
                    case "SCR": return true
                    case "SRD": return true
                    case "SVC": return true
                    case "XRP": return true
                        //            case "BMD": return true don't support
                        //            case "CNH": return true don't support
                        //            case "CUP": return true don't support
                        //            case "EOS": return true don't support
                        //            case "GHS": return true don't support
                        //            case "GIP": return true don't support
                        //            case "GMD": return true don't support
                        //             case "GNF": return true don't support
                        //            case "GYD": return true don't support
                        //            case "IQD": return true don't support
                        //            case "KMF": return true don't support
                        //            case "KYD": return true   don't support
                        //            case "LBP": return true don't support
                        //            case "LRD": return true don't support
                        //            case "LSL": return true don't support
                        //            case "LYD": return true don't support
                        //            case "MAD": return true don't support
                        //            case "MWK": return true don't support
                        //            case "MZN": return true don't support
                        //            case "OMR": return true don't support
                        //            case "PGK": return true don't support
                        //            case "RWF": return true don't support
                        //            case "SBD": return true don't support
                        //            case "SDG": return true don't support
                        //            case "SLL": return true don't support
                        //            case "SOS": return true don't support
                        //            case "ANG": return true don't support
                        //            case "SZL": return true don't support
                        //            case "TJS": return true don't support
                        //            case "TMT": return true don't support
                        //            case "TND": return true don't support
                        //            case "TOP": return true don't support
                        //            case "TTD": return true don't support
                        //            case "TZS": return true don't support
                        //            case "UGX": return true don't support
                        //            case "UZS": return true don't support
                        //            case "XAF": return true don't support
                        //            case "XAG": return true don't support
                        //            case "XAU": return true don't support
                        //            case "XCD": return true don't support
                        //            case "XLM": return true don't support
                        //            case "XOF": return true don't support
                        //            case "YER": return true don't support
                    //            case "ZMW": return true don't support
                    default: return false }
                } else { return false }
            } else { return false }
        }
    }
    
    var coinRate: Double?
    var coinCode: String
    var coinImage: Image {
        get {
            switch coinCode {
            //Premium currency
            case "AFN": return Image("afghanistan").resizable()
            case "ALL": return Image("albania").resizable()
            case "AMD": return Image("armenia").resizable()
            case "AOA": return Image("angola").resizable()
            case "AZN": return Image("azerbaijan").resizable()
            case "BAM": return Image("bosnia-and-herzegovina").resizable()
            case "BBD": return Image("barbados").resizable()
            case "BCH": return Image("bitcoin-cash").resizable()
            case "BDT": return Image("bangladesh").resizable()
            case "BHD": return Image("bahrain").resizable()
            case "BIF": return Image("burundi").resizable()
            case "BND": return Image("brunei").resizable()
            case "BOB": return Image("bolivia").resizable()
            case "BTC": return Image("bitcoin").resizable()
            case "BTG": return Image("bitcoin-gold").resizable()
            case "BWP": return Image("botswana").resizable()
            case "BZD": return Image("belize").resizable()
            case "CDF": return Image("congo").resizable()
            case "CRC": return Image("costa-rica").resizable()
            case "CUC": return Image("cuba").resizable()
            case "CVE": return Image("cape-verde").resizable()
            case "DASH": return Image("dash").resizable()
            case "DJF": return Image("djibouti").resizable()
            case "DZD": return Image("algeria").resizable()
            case "ETB": return Image("ethiopia").resizable()
            case "ETH": return Image("ethereum").resizable()
            case "GEL": return Image("georgia").resizable()
            case "HNL": return Image("honduras").resizable()
            case "HTG": return Image("haiti").resizable()
            case "JMD": return Image("jamaica").resizable()
            case "JOD": return Image("jordan").resizable()
            case "KES": return Image("kenya").resizable()
            case "KGS": return Image("kyrgyzstan").resizable()
            case "KWD": return Image("kuwait").resizable()
            case "LAK": return Image("laos").resizable()
            case "LKR": return Image("sri-lanka").resizable()
            case "LTC": return Image("litecoin").resizable()
            case "MDL": return Image("moldova").resizable()
            case "MKD": return Image("macedonia").resizable()
            case "MMK": return Image("myanmar").resizable()
            case "MOP": return Image("macau").resizable()
            case "MUR": return Image("mauritius").resizable()
            case "MVR": return Image("maldives").resizable()
            case "NGN": return Image("nigeria").resizable()
            case "NIO": return Image("nicaragua").resizable()
            case "NPR": return Image("nepal").resizable()
            case "QAR": return Image("qatar").resizable()
            case "RSD": return Image("serbia").resizable()
            case "SCR": return Image("seychelles").resizable()
            case "SRD": return Image("suriname").resizable()
            case "SVC": return Image("salvador").resizable()
            case "XRP": return Image("xrp").resizable()
                
            case "AED": return Image("morocco").resizable()
            case "ARS": return Image("argentina").resizable()
            case "AUD": return Image("australia").resizable()
            case "BGN": return Image("bulgaria").resizable()
            case "BRL": return Image("brazil").resizable()
            case "BSD": return Image("bahamas").resizable()
            case "CAD": return Image("canada").resizable()
            case "CHF": return Image("switzerland").resizable()
            case "CLP": return Image("chile").resizable()
            case "CNY": return Image("china").resizable()
            case "COP": return Image("colombia").resizable()
            case "CZK": return Image("czech").resizable()
            case "DKK": return Image("denmark").resizable()
            case "DOP": return Image("dominican-republic").resizable()
            case "EGP": return Image("egypt").resizable()
            case "EUR": return Image("EU").resizable()
            case "FJD": return Image("fiji").resizable()
            case "GBP": return Image("united-kingdom").resizable()
            case "GTQ": return Image("guatemala").resizable()
            case "HKD": return Image("hong-kong").resizable()
            case "HRK": return Image("croatia").resizable()
            case "HUF": return Image("hungary").resizable()
            case "IDR": return Image("indonesia").resizable()
            case "ILS": return Image("israel").resizable()
            case "INR": return Image("india").resizable()
            case "ISK": return Image("iceland").resizable()
            case "JPY": return Image("japan").resizable()
            case "KRW": return Image("south-korea").resizable()
            case "KZT": return Image("kazakhstan").resizable()
            case "MXN": return Image("mexico").resizable()
            case "MYR": return Image("malaysia").resizable()
            case "NOK": return Image("norway").resizable()
            case "NZD": return Image("new-zealand").resizable()
            case "PAB": return Image("panama").resizable()
            case "PEN": return Image("peru").resizable()
            case "PHP": return Image("philippines").resizable()
            case "PKR": return Image("pakistan").resizable()
            case "PLN": return Image("poland").resizable()
            case "PYG": return Image("paraguay").resizable()
            case "RON": return Image("romania").resizable()
            case "RUB": return Image("russia").resizable()
            case "SAR": return Image("saudi-arabia").resizable()
            case "SEK": return Image("sweden").resizable()
            case "SGD": return Image("singapore").resizable()
            case "THB": return Image("thailand").resizable()
            case "TRY": return Image("turkey").resizable()
            case "TWD": return Image("taiwan").resizable()
            case "UAH": return Image("ukraine").resizable()
            case "USD": return Image("united-states").resizable()
            case "UYU": return Image("uruguay").resizable()
            case "VND": return Image("vietnam").resizable()
            case "ZAR": return Image("south-africa").resizable()
            default: return Image("questionmark")
            }
        }
    }
    
    var coinCountry: String {
        get {
            switch coinCode {
            //Premium currency
            case "AFN": return NSLocalizedString("Afghanistan", comment: "")
            case "ALL": return NSLocalizedString("Albania", comment: "")
            case "AMD": return NSLocalizedString("Armenia", comment: "")
            case "AOA": return NSLocalizedString("Angola", comment: "")
            case "AZN": return NSLocalizedString("Azerbaijani", comment: "")
            case "BAM": return NSLocalizedString("Bosnia and Herzegovina", comment: "")
            case "BBD": return NSLocalizedString("Barbados", comment: "")
            case "BCH": return NSLocalizedString("Cryptocurrency", comment: "")
            case "BDT": return NSLocalizedString("Bangladesh", comment: "")
            case "BHD": return NSLocalizedString("Bahrain", comment: "")
            case "BIF": return NSLocalizedString("Burundi", comment: "")
            case "BND": return NSLocalizedString("Brunei", comment: "")
            case "BOB": return NSLocalizedString("Bolivia", comment: "")
            case "BTC": return NSLocalizedString("Cryptocurrency", comment: "")
            case "BTG": return NSLocalizedString("Cryptocurrency", comment: "")
            case "BWP": return NSLocalizedString("Botswana", comment: "")
            case "BZD": return NSLocalizedString("Belize", comment: "")
            case "CDF": return NSLocalizedString("Congo", comment: "")
            case "CRC": return NSLocalizedString("Costa Rica", comment: "")
            case "CUC": return NSLocalizedString("Cuba", comment: "")
            case "CVE": return NSLocalizedString("Cape Verde", comment: "")
            case "DASH": return NSLocalizedString("Cryptocurrency", comment: "")
            case "DJF": return NSLocalizedString("Djibouti", comment: "")
            case "DZD": return NSLocalizedString("Algeria", comment: "")
            case "ETB": return NSLocalizedString("Ethiopia", comment: "")
            case "ETH": return NSLocalizedString("Cryptocurrency", comment: "")
            case "GEL": return NSLocalizedString("Georgia", comment: "")
            case "HNL": return NSLocalizedString("Honduras", comment: "")
            case "HTG": return NSLocalizedString("Haiti", comment: "")
            case "JMD": return NSLocalizedString("Jamaica", comment: "")
            case "JOD": return NSLocalizedString("Jordan", comment: "")
            case "KES": return NSLocalizedString("Kenya", comment: "")
            case "KGS": return NSLocalizedString("Kyrgyzstan", comment: "")
            case "KWD": return NSLocalizedString("Kuwait", comment: "")
            case "LAK": return NSLocalizedString("Laos", comment: "")
            case "LKR": return NSLocalizedString("Sri Lanka", comment: "")
            case "LTC": return NSLocalizedString("Cryptocurrency", comment: "")
            case "MDL": return NSLocalizedString("Moldova", comment: "")
            case "MKD": return NSLocalizedString("Macedonia", comment: "")
            case "MMK": return NSLocalizedString("Myanmar", comment: "")
            case "MOP": return NSLocalizedString("Macau", comment: "")
            case "MUR": return NSLocalizedString("Mauritius", comment: "")
            case "MVR": return NSLocalizedString("Maldives", comment: "")
            case "NGN": return NSLocalizedString("Nigeria", comment: "")
            case "NIO": return NSLocalizedString("Nicaragua", comment: "")
            case "NPR": return NSLocalizedString("Nepal", comment: "")
            case "QAR": return NSLocalizedString("Qatar", comment: "")
            case "RSD": return NSLocalizedString("Serbia", comment: "")
            case "SCR": return NSLocalizedString("Seychelles", comment: "")
            case "SRD": return NSLocalizedString("Suriname", comment: "")
            case "SVC": return NSLocalizedString("El Salvador", comment: "")
            case "XRP": return NSLocalizedString("Cryptocurrency", comment: "")
                
            case "AED": return NSLocalizedString("Morocco", comment: "")
            case "ARS": return NSLocalizedString("Argentina", comment: "")
            case "AUD": return NSLocalizedString("Australia", comment: "")
            case "BGN": return NSLocalizedString("Bulgaria", comment: "")
            case "BRL": return NSLocalizedString("Brazil", comment: "")
            case "BSD": return NSLocalizedString("Bahamas", comment: "")
            case "CAD": return NSLocalizedString("Canada", comment: "")
            case "CHF": return NSLocalizedString("Switzerland", comment: "")
            case "CLP": return NSLocalizedString("Chile", comment: "")
            case "CNY": return NSLocalizedString("China", comment: "")
            case "COP": return NSLocalizedString("Colombia", comment: "")
            case "CZK": return NSLocalizedString("Czech", comment: "")
            case "DKK": return NSLocalizedString("Denmark", comment: "")
            case "DOP": return NSLocalizedString("Dominican-republic", comment: "")
            case "EGP": return NSLocalizedString("Egypt", comment: "")
            case "EUR": return NSLocalizedString("European Union", comment: "")
            case "FJD": return NSLocalizedString("Fiji", comment: "")
            case "GBP": return NSLocalizedString("United-Kingdom", comment: "")
            case "GTQ": return NSLocalizedString("Guatemala", comment: "")
            case "HKD": return NSLocalizedString("Hong-Kong", comment: "")
            case "HRK": return NSLocalizedString("Croatia", comment: "")
            case "HUF": return NSLocalizedString("Hungary", comment: "")
            case "IDR": return NSLocalizedString("Indonesia", comment: "")
            case "ILS": return NSLocalizedString("Israel", comment: "")
            case "INR": return NSLocalizedString("India", comment: "")
            case "ISK": return NSLocalizedString("Iceland", comment: "")
            case "JPY": return NSLocalizedString("Japan", comment: "")
            case "KRW": return NSLocalizedString("South-Korea", comment: "")
            case "KZT": return NSLocalizedString("Kazakhstan", comment: "")
            case "MXN": return NSLocalizedString("Mexico", comment: "")
            case "MYR": return NSLocalizedString("Malaysia", comment: "")
            case "NOK": return NSLocalizedString("Norway", comment: "")
            case "NZD": return NSLocalizedString("New-Zealand", comment: "")
            case "PAB": return NSLocalizedString("Panama", comment: "")
            case "PEN": return NSLocalizedString("Peru", comment: "")
            case "PHP": return NSLocalizedString("Philippines", comment: "")
            case "PKR": return NSLocalizedString("Pakistan", comment: "")
            case "PLN": return NSLocalizedString("Poland", comment: "")
            case "PYG": return NSLocalizedString("Paraguay", comment: "")
            case "RON": return NSLocalizedString("Romania", comment: "")
            case "RUB": return NSLocalizedString("Russia", comment: "")
            case "SAR": return NSLocalizedString("Saudi-Arabia", comment: "")
            case "SEK": return NSLocalizedString("Sweden", comment: "")
            case "SGD": return NSLocalizedString("Singapore", comment: "")
            case "THB": return NSLocalizedString("Thailand", comment: "")
            case "TRY": return NSLocalizedString("Turkey", comment: "")
            case "TWD": return NSLocalizedString("Taiwan", comment: "")
            case "UAH": return NSLocalizedString("Ukraine", comment: "")
            case "USD": return NSLocalizedString("United-States", comment: "")
            case "UYU": return NSLocalizedString("Uruguay", comment: "")
            case "VND": return NSLocalizedString("Vietnam", comment: "")
            case "ZAR": return NSLocalizedString("South-Africa", comment: "")
            default: return ""
            }
        }
    }
    var coinName: String {
        get {
            switch coinCode {
            //Premium currency
            case "AFN": return NSLocalizedString("Afghan afghani", comment: "")
            case "ALL": return NSLocalizedString("Albanian lek", comment: "")
            case "AMD": return NSLocalizedString("Armenian dram", comment: "")
            case "AOA": return NSLocalizedString("Angolan kwanza", comment: "")
            case "AZN": return NSLocalizedString("Azerbaijani manat", comment: "")
            case "BAM": return NSLocalizedString("Bosnian Convertible Mark", comment: "")
            case "BBD": return NSLocalizedString("Barbados Dollar", comment: "")
            case "BCH": return NSLocalizedString("Bitcoin Cash", comment: "")
            case "BDT": return NSLocalizedString("Bangladeshi taka", comment: "")
            case "BHD": return NSLocalizedString("Bahraini dinar", comment: "")
            case "BIF": return NSLocalizedString("Burundian franc", comment: "")
            case "BND": return NSLocalizedString("Brunei dollar", comment: "")
            case "BOB": return NSLocalizedString("Boliviano", comment: "")
            case "BTC": return NSLocalizedString("Bitcoin", comment: "")
            case "BTG": return NSLocalizedString("Bitcoin Gold", comment: "")
            case "BWP": return NSLocalizedString("Botswana pula", comment: "")
            case "BZD": return NSLocalizedString("Belize dollar", comment: "")
            case "CDF": return NSLocalizedString("Congolese franc", comment: "")
            case "CRC": return NSLocalizedString("Costa Rican colón", comment: "")
            case "CUC": return NSLocalizedString("Cuban convertible peso", comment: "")
            case "CVE": return NSLocalizedString("Cape Verdean escudo", comment: "")
            case "DASH": return NSLocalizedString("Dash", comment: "")
            case "DJF": return NSLocalizedString("Djiboutian franc", comment: "")
            case "DZD": return NSLocalizedString("Algerian dinar", comment: "")
            case "ETB": return NSLocalizedString("Ethiopian birr", comment: "")
            case "ETH": return NSLocalizedString("Ethereum", comment: "")
            case "GEL": return NSLocalizedString("Georgian lari", comment: "")
            case "HNL": return NSLocalizedString("Honduran lempira", comment: "")
            case "HTG": return NSLocalizedString("Haitian gourde", comment: "")
            case "JMD": return NSLocalizedString("Jamaican dollar", comment: "")
            case "JOD": return NSLocalizedString("Jordanian dinar", comment: "")
            case "KES": return NSLocalizedString("Kenyan shilling", comment: "")
            case "KGS": return NSLocalizedString("Kyrgyzstani som", comment: "")
            case "KWD": return NSLocalizedString("Kuwaiti dinar", comment: "")
            case "LAK": return NSLocalizedString("Lao kip", comment: "")
            case "LKR": return NSLocalizedString("Sri Lankan rupee", comment: "")
            case "LTC": return NSLocalizedString("Litecoin", comment: "")
            case "MDL": return NSLocalizedString("Moldovan leu", comment: "")
            case "MKD": return NSLocalizedString("Macedonian denar", comment: "")
            case "MMK": return NSLocalizedString("Burmese kyat", comment: "")
            case "MOP": return NSLocalizedString("Macanese pataca", comment: "")
            case "MUR": return NSLocalizedString("Mauritian rupee", comment: "")
            case "MVR": return NSLocalizedString("Maldivian rufiyaa", comment: "")
            case "NGN": return NSLocalizedString("Nigerian naira", comment: "")
            case "NIO": return NSLocalizedString("Nicaraguan córdoba", comment: "")
            case "NPR": return NSLocalizedString("Nepalese rupee", comment: "")
            case "QAR": return NSLocalizedString("Qatari Riyal", comment: "")
            case "RSD": return NSLocalizedString("Serbian dinar", comment: "")
            case "SCR": return NSLocalizedString("Seychellois rupee", comment: "")
            case "SRD": return NSLocalizedString("Suriname Dollar", comment: "")
            case "SVC": return NSLocalizedString("Salvadoran colón", comment: "")
            case "XRP": return NSLocalizedString("Ripple", comment: "")
            case "AED": return NSLocalizedString("Moroccan dirham", comment: "")
            case "ARS": return NSLocalizedString("Argentine peso", comment: "")
            case "AUD": return NSLocalizedString("Australian dollar", comment: "")
            case "BGN": return NSLocalizedString("Bulgarian lev", comment: "")
            case "BRL": return NSLocalizedString("Brazilian real", comment: "")
            case "BSD": return NSLocalizedString("Bahamian dollar", comment: "")
            case "CAD": return NSLocalizedString("Canadian dollar", comment: "")
            case "CHF": return NSLocalizedString("Swiss franc", comment: "")
            case "CLP": return NSLocalizedString("Chilean peso", comment: "")
            case "CNY": return NSLocalizedString("Renminbi", comment: "")
            case "COP": return NSLocalizedString("Colombian peso", comment: "")
            case "CZK": return NSLocalizedString("Czech koruna", comment: "")
            case "DKK": return NSLocalizedString("Danish krone", comment: "")
            case "DOP": return NSLocalizedString("Dominican peso", comment: "")
            case "EGP": return NSLocalizedString("Egyptian pound", comment: "")
            case "EUR": return NSLocalizedString("Euro", comment: "")
            case "FJD": return NSLocalizedString("Fijian dollar", comment: "")
            case "GBP": return NSLocalizedString("Pound sterling", comment: "")
            case "GTQ": return NSLocalizedString("Guatemalan quetzal", comment: "")
            case "HKD": return NSLocalizedString("Hong Kong dollar", comment: "")
            case "HRK": return NSLocalizedString("Croatian kuna", comment: "")
            case "HUF": return NSLocalizedString("Hungarian forint", comment: "")
            case "IDR": return NSLocalizedString("Indonesian rupiah", comment: "")
            case "ILS": return NSLocalizedString("Israeli Shekel", comment: "")
            case "INR": return NSLocalizedString("Indian rupee", comment: "")
            case "ISK": return NSLocalizedString("Icelandic króna", comment: "")
            case "JPY": return NSLocalizedString("Japanese yen", comment: "")
            case "KRW": return NSLocalizedString("South Korean won", comment: "")
            case "KZT": return NSLocalizedString("Kazakhstani tenge", comment: "")
            case "MXN": return NSLocalizedString("Mexican peso", comment: "")
            case "MYR": return NSLocalizedString("Malaysian ringgit", comment: "")
            case "NOK": return NSLocalizedString("Norwegian krone", comment: "")
            case "NZD": return NSLocalizedString("New Zealand dollar", comment: "")
            case "PAB": return NSLocalizedString("Panamanian balboa", comment: "")
            case "PEN": return NSLocalizedString("Sol", comment: "")
            case "PHP": return NSLocalizedString("Philippine peso", comment: "")
            case "PKR": return NSLocalizedString("Pakistani rupee", comment: "")
            case "PLN": return NSLocalizedString("Polish złoty", comment: "")
            case "PYG": return NSLocalizedString("Paraguayan guaraní", comment: "")
            case "RON": return NSLocalizedString("Romanian leu", comment: "")
            case "RUB": return NSLocalizedString("Russian Rouble", comment: "")
            case "SAR": return NSLocalizedString("Saudi riyal", comment: "")
            case "SEK": return NSLocalizedString("Swedish krona", comment: "")
            case "SGD": return NSLocalizedString("Singapore dollar", comment: "")
            case "THB": return NSLocalizedString("Thai baht", comment: "")
            case "TRY": return NSLocalizedString("Turkish lira", comment: "")
            case "TWD": return NSLocalizedString("New Taiwan dollar", comment: "")
            case "UAH": return NSLocalizedString("Ukrainian hryvnia", comment: "")
            case "USD": return NSLocalizedString("United States Dollar", comment: "")
            case "UYU": return NSLocalizedString("Peso Uruguayo", comment: "")
            case "VND": return NSLocalizedString("Vietnamese dong", comment: "")
            case "ZAR": return NSLocalizedString("South African rand", comment: "")
            default: return ""
            }
        }
    }
}
