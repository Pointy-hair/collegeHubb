//
//  AppDelegate.swift
//  CollegeHub
//
//  Created by Sumanpreet on 24/01/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import FBSDKShareKit
import Google
import GoogleSignIn
import GooglePlaces
import GoogleMaps
import IQKeyboardManagerSwift
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize Google sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        GIDSignIn.sharedInstance().delegate = self
        
        let kPlacesAPIKey = "AIzaSyC4g7UzsVfR8I7XrIBTV64NeWO-3lj4Ul4"
        let kMapsAPIKey = "AIzaSyAZCfa7_pNG2zepm-lbbgwIYJzmZZiFCO0"

        // Provide the Places API with your API key.
        GMSPlacesClient.provideAPIKey(kPlacesAPIKey)
        // Provide the Maps API with your API key. We need to provide this as well because the Place
        // Picker displays a Google Map.
        GMSServices.provideAPIKey(kMapsAPIKey)

        IQKeyboardManager.sharedManager().enable = true
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if ((UserDataSingleton.sharedInstance.loggedInUser?.access_token) != nil && UserDataSingleton.sharedInstance.loggedInUser?.is_verified == "1") {
            let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "CustomTabbarController") as? CustomTabbarController
            self.window?.rootViewController = tabBarController
            self.window?.makeKeyAndVisible()
        }else{
            let navController = mainStoryboard.instantiateViewController(withIdentifier: "initialNavController") as? UINavigationController
            self.window?.rootViewController = navController
            self.window?.makeKeyAndVisible()
        }
        STPPaymentConfiguration.shared().publishableKey = "pk_test_ikiKdCU8hnlWG065h2K82b2C"
        STPPaymentConfiguration.shared().appleMerchantIdentifier = "ca_AFvnodjTd6kCG0S2Jx9E4RlvuGLKwrja"

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()

        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        GIDSignIn.sharedInstance().handle(url,
                                          sourceApplication: sourceApplication,
                                          annotation: annotation)
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        
        FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // [START signin_handler]
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            // [START_EXCLUDE silent]
//            NotificationCenter.default.post(
//                name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
            // [END_EXCLUDE]
        } else {
            
            // [START_EXCLUDE]
            let googleUserData:[String: GIDGoogleUser] = ["data": user]
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"),
                object: nil,
                userInfo:googleUserData)
            
            // [END_EXCLUDE]
        }
    }
    // [END signin_handler]
    // [START disconnect_handler]
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // [START_EXCLUDE]
//        NotificationCenter.default.post(
//            name: Notification.Name(rawValue: "ToggleAuthUINotification"),
//            object: nil,
//            userInfo: ["statusText": "User has disconnected."])
        // [END_EXCLUDE]
    }
    // [END disconnect_handler]


}

