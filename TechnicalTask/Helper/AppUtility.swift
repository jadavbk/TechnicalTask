//
//  AppUtility.swift
//
//
//  Created by Bharat Jadav on 02/07/21.
//

import Foundation
import UIKit
import SwiftUI
//import Firebase
//import FirebaseAnalytics

class AppUtility: NSObject {
    static let shared = AppUtility()
    var userSettings = UserSettings()
    var apiResponseMessage : String = ""
    var apiErrorCode       : Int = 0
    var fcmToken           : String = ""
    var customValue        : String = ""
    
    public override init() {
        super.init()
        intialize()
    }
    func intialize() {
        
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passWordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passWordRegEx)
        return passwordTest.evaluate(with: password)
    }
}

//MARK: - Set Print Option
extension AppUtility {
    func printToConsole(_ object : Any) {
        #if DEBUG
        Swift.print(object)
        #endif
    }
}

//MARK: - Gloabl Alert View
extension AppUtility {
    func showAlertWith(_ title:String, _ message:String, completion:@escaping(_ action:Bool?) -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: UIAlertController.Style.alert
            )
            
            alert.addAction(UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: { action in
                    completion(true)
                }
            ))
            
            DispatchQueue.main.async {
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func getRootViewController() -> UIViewController? {
        return UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first?.rootViewController
    }
    
//    func redirectToLoginScreen() {
//        DispatchQueue.main.async {
//            if let window = UIApplication.shared.windows.first {
//                AppUtility.shared.userSettings.islogin = false
//                AppUtility.shared.userSettings.authToken = ""
//                let homeView = WelcomeView()
//                window.rootViewController = UIHostingController(rootView: homeView)
//                window.makeKeyAndVisible()
//            }
//        }
//    }
//    
//    func redirectToMainScreen() {
//        DispatchQueue.main.async {
//            if let window = UIApplication.shared.windows.first {
//                let homeView = MainTabView()
//                window.rootViewController = UIHostingController(rootView: homeView)
//                window.makeKeyAndVisible()
//            }
//        }
//    }
}

////MARK:- Custom Alert View
//extension AppUtility {
//    func showCustomAlert(alertType: AlertType, message: String, actionButtonTitle: String?, cancelButtonTitle: String, buttonActionCompletion: AlertButtonActionCompletion?) {
//        DispatchQueue.main.async {
//            guard let window = UIApplication.shared.windows.first else { return }
//            let alert = CustomAlertView(alertType: alertType, message: message, actionButtonTitle: actionButtonTitle, cancelButtonTitle: cancelButtonTitle, buttonActionCompletion: { action in
//                window.rootViewController?.dismiss(animated: false, completion: {
//                    buttonActionCompletion?(action)
//                })
//            })
//            let hostVC = UIHostingController(rootView: alert)
//            hostVC.modalPresentationStyle = .overCurrentContext
//            hostVC.view.backgroundColor = .clear
//            window.rootViewController?.dismiss(animated: false, completion: nil)
//            window.rootViewController?.present(hostVC, animated: false, completion: nil)
//        }
//    }
//}

////MARK:- Show Loader
//extension AppUtility {
//    func showGlobalLoader(animating : Bool) {
//        DispatchQueue.main.async {
//            guard let window = UIApplication.shared.windows.first else { return }
//            let loader = IndicatorView(isAnimating: animating)
//            let hostVC = UIHostingController(rootView: loader)
//            hostVC.modalPresentationStyle = .overCurrentContext
//            hostVC.view.backgroundColor = .clear
//            if animating {
//                window.rootViewController?.present(hostVC, animated: false, completion: nil)
//            }
//            else {
//                window.rootViewController?.dismiss(animated: false, completion: nil)
//            }
//        }
//    }
//}

/* Commented for Firebase, Analytics not implemented
//MARK:- Firebase event
extension AppUtility {
    func logFirebaseEvent(_ title : String) {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(title)",
            AnalyticsParameterItemName: title,
          AnalyticsParameterContentType: "cont",
        ])
    }
} */

//MARK: - Force Update Version
extension AppUtility {
    func isAppUpdateAvailable() -> Bool {
        var upgradeAvailable = false
        // Get the main bundle of the app so that we can determine the app's version number
        let bundle = Bundle.main
        if let infoDictionary = bundle.infoDictionary {
            // The URL for this app on the iTunes store uses the Apple ID for the  This never changes, so it is a constant
            let bundleID = infoDictionary["CFBundleIdentifier"] as? String
            let storeInfoURL: String = "http://itunes.apple.com/lookup?bundleId=\(bundleID ?? "")"
            
            let urlOnAppStore = NSURL(string: storeInfoURL)
            if let dataInJSON = NSData(contentsOf: urlOnAppStore! as URL) {
                // Try to deserialize the JSON that we got
                if let dict: NSDictionary = try? JSONSerialization.jsonObject(with: dataInJSON as Data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] as NSDictionary? {
                    if let results:NSArray = dict["results"] as? NSArray {
                        if results.count > 0 {
                            let dictVersion = results[0] as AnyObject
                            if let version = dictVersion["version"] as? String {
                                print("Latest Version of App : \(version)")
                                if let currentVersion = infoDictionary["CFBundleShortVersionString"] as? String {
                                    // Check if they are the same. If not, an upgrade is available.
                                    if version != currentVersion {
                                        upgradeAvailable = true
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return upgradeAvailable
    }

    /* Commented for Force update version not implemented.
    // MARK:- server request for fetch
    func getUpdateVersion() {
        APIService.shared.requestWithGet(resourceType: .setting, value: "", requestType: .get, completion: { (result:Result<ForceUpdateModel?, Error>) in
            switch result {
            case .success(let response):
                self.printToConsole(response as Any)
                guard let resData = response else {
                    return
                }
                //self.getForceUpdateWithDict(appData: resData)
            case .failure(let error):
                AppUtility.shared.printToConsole(error)
            }
        })
    }
    
    func getForceUpdateWithDict(appData: ForceUpdateModel)  {
        ForceUpdateVC.showMsgPopup(strTitle: "Update Available", forceModel: appData, completion: { (sender) -> Void in
            print("\(sender.tag)")
            if sender.tag == 101 {
                if let url = URL(string: K.URL.ITUNE_APP_URL), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        // Fallback on earlier versions
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            else {
            }
        })
    } */
}
