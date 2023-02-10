//  Created by Daniyar Mamadov on 10.02.2023.

import Foundation
import VK_ios_sdk

final private class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appID = "51549134"
    private let vksdk: VKSdk
    
    init(vksdk: VKSdk) {
        self.vksdk = VKSdk.initialize(withAppId: appID)
        super.init()
        print("VKSDK initialized.")
        vksdk.register(self)
        vksdk.uiDelegate = self
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
