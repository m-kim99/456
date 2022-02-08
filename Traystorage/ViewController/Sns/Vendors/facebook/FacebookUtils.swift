//
//  FacebookUtils.swift
//  GetSome
//
//  Created by mario on 9/25/18.
//  Copyright © 2018 Dev. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

class FacebookUtils {
    public static let CANCELLED = -1
    public static let GET_INFO = -2
    static let INFO_PARAMS = ["fields": "id,name,email"]
    static let LOGIN_PERMISSONS = ["public_profile", "email"]
    
    public static func loginFacebook(from_vc:UIViewController, callback:@escaping (_ userId: String,_ token:String) -> (),
                                     error_callback:@escaping (_ error:Error) -> ()){
        if(AccessToken.current != nil) {
            let token = AccessToken.current
            callback(token!.userID, token!.tokenString)
        }
        else {
            let loginManager = LoginManager()
            loginManager.logIn(permissions: LOGIN_PERMISSONS, from: from_vc) { (result, error) in
                if (error == nil){
                    if(result?.isCancelled)! {
                        let error = NSError(domain: "cancelled", code: CANCELLED)
                        error_callback(error)
                    } else {
                        callback(result!.token!.userID, result!.token!.tokenString)
                    }
                }
                else {
                    error_callback(error!)
                }
            }
        }
    }
    
    public static func getFacebookInfo(from_vc:UIViewController, callback:@escaping(_ userInfo:FacebookUserInfo)->(), error_callback:@escaping (_ error:Error) -> ()) {
        
        if(AccessToken.current == nil) {
            loginFacebook(from_vc: from_vc, callback: { (userID, userToken) in
                getFacebookInfo(from_vc: from_vc, callback: callback, error_callback: error_callback)
            }) { (error) in
                error_callback(error)
            }
            
            return
        }
        
        let request = GraphRequest(graphPath: "me", parameters: INFO_PARAMS)
        request.start { (connection, result, error) in
            if error == nil {
                let w_result = result as! [String: AnyObject?]
                let snsId : String = (w_result["id"] as? String) ?? ""
                let snsIdVal =  Int64(snsId)
                if (snsId.isEmpty || snsIdVal == nil) {
                    let error = NSError(domain: "cancelled", code: GET_INFO)
                    error_callback(error)
                    return
                }
                
                let snsName : String = (w_result["name"] as? String) ?? ""
                let snsEmail : String = (w_result["email"] as? String) ?? ""
                let snsGender : String = (w_result["gender"] as? String) ?? ""
                
                let facebookInfo = FacebookUserInfo()
                facebookInfo.id = snsIdVal!
                facebookInfo.email = snsEmail
                facebookInfo.gender = snsGender
                facebookInfo.name = snsName
                
                callback(facebookInfo)
            }
            else {
                error_callback(error!)
            }
        }
    }
    
    public static func logoutFacebook(){
           let loginManager = LoginManager()
           loginManager.logOut()
       }

}
