//
//  AppDelegate.swift
//  Traystorage
//
//  Created by Star_Man on 1/5/22.
//
import Firebase
import UIKit
import FBSDKCoreKit
import NaverThirdPartyLogin
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let thirdConn: NaverThirdPartyLoginConnection = NaverThirdPartyLoginConnection.getSharedInstance()
        thirdConn.isNaverAppOauthEnable = true
        thirdConn.isInAppOauthEnable = true
        thirdConn.setOnlyPortraitSupportInIphone(true)
        thirdConn.serviceUrlScheme = kServiceAppUrlScheme
        thirdConn.consumerKey = kConsumerKey
        thirdConn.consumerSecret = kConsumerSecret
        thirdConn.setOnlyPortraitSupportInIphone(true)
        
        GIDSignIn.sharedInstance().clientID = GOOGLEKEY
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
            // Handle the deep link. For example, show the deep-linked content or
            // apply a promotional offer to the user's account.
            // ...
            return true
          }
        // kakao
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        let handled: Bool = ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        return handled
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        // kakao
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        let scheme = url.scheme
        if (scheme?.contains("fb"))! {
            return ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        }
        NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options)
        return application(app, open: url,
                            sourceApplication: options[UIApplication.OpenURLOptionsKey
                              .sourceApplication] as? String,
                            annotation: "")
    }
       
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        // kakao
        if KOSession.isKakaoAccountLoginCallback(url as URL) {
            return KOSession.handleOpen(url as URL)
        }
        return false
    }
       
    func applicationDidBecomeActive(_ application: UIApplication) {
        //        FBSDKAppEvents.activateApp()
        KOSession.handleDidBecomeActive()
    }
       
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("1. Message ID: \(messageID)")
        }
           
        // Print full message.
        print(userInfo)
    }
       
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("2. Message ID: \(messageID)")
        }
           
        // Print full message.
        print(userInfo)
           
        if application.applicationState == .active {
            // app is currently active, can update badges count here
            print("active state")
               
        } else if application.applicationState == .background {
            // app is in background, if content-available key of your notification is set to 1, poll to your backend to retrieve data and update your interface here
            print("background state")
               
        } else if application.applicationState == .inactive {
            // app is transitioning from background to foreground (user taps notification), do what you need when user taps here
            print("inactive state")
        }
           
        completionHandler(UIBackgroundFetchResult.newData)
    }

    // [END receive_message]
       
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
       
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
           
        // With swizzling disabled you must set the APNs token here.
//        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
      let handled = DynamicLinks.dynamicLinks()
        .handleUniversalLink(userActivity.webpageURL!) { dynamiclink, error in
            if error != nil {
                print(error)
            }
          print(dynamiclink)
        }

      return handled
    }
}
