import SwiftUI

public let height = UIScreen.main.bounds.height
public let width = UIScreen.main.bounds.width
public let rubik = "Rubik"
public let darkBlue = "dark blue"
public let black = "black"
public let darker = "darker"
public let melon = "melon"
public let space = "space"
public let peach = "peach"
public let red = "red"
public let ebony = "ebony clay"
var didTwentyFourHoursPass: Bool {
    get {
        let savedTime = UserDefaults.standard.double(forKey: "lastWatched")
        let currentTime =  Date().timeIntervalSince1970
        let timeDifference = currentTime - savedTime
        let twentyFourHoursInUnixTimeStamp = 86400.0
        if savedTime > 0.0 && timeDifference < twentyFourHoursInUnixTimeStamp {
            return false
        } else { return true }
    }
}
