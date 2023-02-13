//  Created by Daniyar Mamadov on 10.02.2023.

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: AnyObject {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInFailed()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appID = "51549134"
    private let vksdk: VKSdk
    
    weak var delegate: AuthServiceDelegate?
    
    override init() {
        self.vksdk = VKSdk.initialize(withAppId: appID)
        super.init()
        print("VKSDK initialized.")
        vksdk.register(self)
        vksdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["offline"]
        VKSdk.wakeUpSession(scope) { state, error in
            switch state {
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
            case .authorized:
                print("authorized")
            default:
                print(#function)
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        delegate?.authServiceSignIn()
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceSignInFailed()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
