import SwiftUI

class HostingController: UIHostingController<AnyView> {
   override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
   }
}
