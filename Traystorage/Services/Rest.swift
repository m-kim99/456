import Alamofire
import Foundation
import SwiftyJSON
import UIKit

class Rest: Net {
    public static var user: ModelUser!

    public static func appInfo(
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        doRequest(method: .post, api: .APP_INFO, params: [:], header: [:], success: success, failure: failure)
    }
    
    public static func login(
        id: String!,
        pwd: String!,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
//        let token = Local.getPushKey()
        let params = [
            "login_id": id,
            "password": pwd,
//            "dev_type": "ios",
//            "dev_token": token
        ]

        doRequest(method: .post, api: .USER_LOGIN, params: params as [String: AnyObject], header: [:], success: success, failure: failure)
    }
    
    public static func sendCertKey(
        email: String!,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "email": email
        ]

        doRequest(method: .post, api: .USER_SEND_CERTKEY_EMAIL, params: params as [String: AnyObject], header: [:], success: success, failure: failure)
    }
    
    public static func sendCertKey(
        phone: String!,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "phone": phone
        ]

        doRequest(method: .post, api: .USER_SEND_CERTKEY_PHONE, params: params as [String: AnyObject], header: [:], success: success, failure: failure)
    }
    
    public static func verifyCertKey(
        email: String!,
        certKey: String!,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "email": email,
            "cert_key": certKey
        ]

        doRequest(method: .post, api: .USER_VERIFY_CERTKEY_EMAIL, params: params as [String: AnyObject], header: [:], success: success, failure: failure)
    }
    
    public static func verifyPhoneCode(
        phone: String,
        code: String,
        isContinue: Int,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "phone_number": phone,
            "code": code,
            "is_continue": isContinue.description
        ]

        doRequest(method: .post, api: .USER_VERIFY_CERTKEY_PHONE, params: params as [String: AnyObject], header: [:], success: success, failure: failure)
    }
    
    public static func signup(
        login_id: String,
        pwd: String,
        phone: String,
        code: String,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "login_id": login_id,
            "phone_number": phone,
            "password": pwd,
            "code": code,
            "signup_type": 0
        ] as [String: AnyObject]

        doRequest(method: .post, api: .USER_SIGNUP, params: params as [String: AnyObject], header: [:], success: success, failure: failure)
    }
    
    public static func find_login_id(
        phoneNumber: String,
        code: String,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "phone_number": phoneNumber,
            "code": code
        ] as [String: AnyObject]

        doRequest(method: .post, api: .USER_FIND_ID, params: params as [String: AnyObject], header: [:], success: success, failure: failure)
    }
    
    public static func request_code(
        phoneNumber: String,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "phone_number": phoneNumber
        ] as [String: AnyObject]

        doRequest(method: .post, api: .REQUEST_CODE, params: params as [String: AnyObject], header: [:], success: success, failure: failure)
    }
    
    public static func send_code(
        phoneNumber: String,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "phone_number": phoneNumber
        ] as [String: AnyObject]

        doRequest(method: .post, api: .SEND_CODE, params: params as [String: AnyObject], header: [:], success: success, failure: failure)
    }
    
    public static func findPwd(
        loginid:String,
        phoneNumber:String,
        code: String,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "login_id": loginid,
            "phone_number": phoneNumber,
            "code": code,
        ] as [String: AnyObject]

        doRequest(method: .post, api: .USER_FIND_PWD, params: params as [String: AnyObject], header: [:], success: success, failure: failure)
    }
    
    public static func resetPwd(
        email: String!,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "email": email
        ] as [String: AnyObject]

        doRequest(method: .post, api: .USER_RESET_PWD, params: params as [String: AnyObject], header: [:], success: success, failure: failure)
    }
    
//    public static func userBadgeInfo(
//        type: String!,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token,
//            "type": type
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .USER_BADGE_INFO, params: params as [String: AnyObject], header: [:], success: success, failure: failure)
//    }
//    
//    public static func userStoneInfo(
//        type: String!,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token,
//            "type": type
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .USER_STONE_INFO, params: params as [String: AnyObject], header: [:], success: success, failure: failure)
//    }
//    
    public static func otherUserInfo(
        user_uid: String!,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "access_token": user.access_token!,
            "user_uid": user_uid!
        ] as [String: AnyObject]

        doRequest(method: .post, api: .USER_OTHER_INFO, params: params as [String: AnyObject], header: [:], success: success, failure: failure)
    }
    
    public static func makeProfile(
        name: String,
        birthday: String,
        gender: Int,
        email:String,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "access_token": user.access_token,
            "name": name,
            "birthday": birthday,
            "gender": gender.description,
            "email": email,
        ] as [String: AnyObject]
        
        doRequest(method: .post, api: .MAKE_PROFILE, params: params as [String: AnyObject], header: [:], success: success, failure: failure)
    }
    
    public static func changeProfile(
        file: Data!,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "access_token": user.access_token
        ] as [String: AnyObject]
        
        doRequestForFile(method: .post, api: .CHANGE_PROFILE, imgArray: [file], imgMark: "uploadfile", params: params as [String: AnyObject], success: success, failure: failure)
    }
//    
//    public static func changeAlarm(
//        type: String!,
//        alarm_yn: String!,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token,
//            "type": type!,
//            "alarm_yn": alarm_yn!
//        ] as [String: AnyObject]
//        
//        doRequest(method: .post, api: .CHANGE_ALARM, params: params as [String: AnyObject], header: [:], success: success, failure: failure)
//    }
    
    public static func changePwd(
        loginID: String,
        phone: String,
        code: String,
        password: String,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "login_id": loginID,
            "phone_number": phone,
            "code": code,
            "password": password,
        ] as [String: AnyObject]
        
        doRequest(method: .post, api: .CHANGE_PWD, params: params as [String: AnyObject], header: [:], success: success, failure: failure)
    }
//    
//    public static func homeData(
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .HOME_DATA, params: params as [String: AnyObject], header: [:], success: success, failure: failure)
//    }
    
    public static func popupInfo(
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "access_token": user.access_token!,
            "platform": 1
        ] as [String: AnyObject]

        doRequest(method: .post, api: .POPUP_INFO, params: params, header: [:], success: success, failure: failure)
    }
    
    
    public static func documentList(
        keyword: String,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "access_token": user.access_token!,
            "keyword": keyword
        ] as [String: AnyObject]

        doRequest(method: .post, api: .DOCUMENT_LIST, params: params, header: [:], success: success, failure: failure)
    }
    
    public static func documentDetail(
        documentID: Int,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "access_token": user.access_token!,
            "id": documentID
        ] as [String: AnyObject]

        doRequest(method: .post, api: .DOCUMENT_DETAIL, params: params, header: [:], success: success, failure: failure)
    }
    
    
    public static func documentInsert(
        title: String,
        content: String,
        label: Int,
        tags: String,
        images: String,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "access_token": user.access_token!,
            "title": title,
            "content": content,
            "label": label,
            "tags": tags,
            "images": images,
        ] as [String: AnyObject]

        doRequest(method: .post, api: .DOCUMENT_INSERT, params: params, header: [:], success: success, failure: failure)
    }
    
    public static func documentUpdate(
        id: String,
        title: String,
        content: String,
        label: Int,
        tags: String,
        images: String,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "access_token": user.access_token!,
            "id": id,
            "title": title,
            "content": content,
            "label": label,
            "tags": tags,
            "images": images,
        ] as [String: AnyObject]

        doRequest(method: .post, api: .DOCUMENT_UPDATE, params: params, header: [:], success: success, failure: failure)
    }
    
    
    public static func documentDelete(
        id: String,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "access_token": user.access_token!,
            "id": id
        ] as [String: AnyObject]

        doRequest(method: .post, api: .DOCUMENT_DELETE, params: params, header: [:], success: success, failure: failure)
    }
    
    public static func challengeList(
        page: Int!,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "access_token": user.access_token!,
            "page": page!
        ] as [String: AnyObject]

        doRequest(method: .post, api: .CHALLENGE_LIST, params: params, header: [:], success: success, failure: failure)
    }
    
    public static func challengeDetail(
        challenge_uid: Int!,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "access_token": user.access_token!,
            "challenge_uid": challenge_uid!
        ] as [String: AnyObject]

        doRequest(method: .post, api: .CHALLENGE_DETAIL, params: params, header: [:], success: success, failure: failure)
    }
    
//    public static func challengeLike(
//        challenge_uid: Int?,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!,
//            "challenge_uid": challenge_uid!
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .CHALLENGE_LIKE, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func challengeVote(
//        challenge_uid: Int?,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!,
//            "challenge_uid": challenge_uid!
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .CHALLENGE_VOTE, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func challengeJoinList(
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!,
//            "type": "process"
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .CHALLENGE_JOIN_LIST, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func challengeMyList(
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .CHALLENGE_MY_LIST, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func userChallengeList(
//        user_uid: Int!,
//        type: String!,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!,
//            "type": type!,
//            "user_uid": user_uid!
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .CHALLENGE_USER_LIST, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func videoList(
//        page: Int!,
//        challenge_uid: Int?,
//        user_uid: Int?,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        var params = [
//            "access_token": user.access_token!,
//            "page": page!
//        ] as [String: AnyObject]
//        
//        if challenge_uid != nil {
//            params["challenge_uid"] = challenge_uid as AnyObject?
//        }
//        
//        if user_uid != nil {
//            params["user_uid"] = user_uid as AnyObject?
//        }
//
//        doRequest(method: .post, api: .VIDEO_LIST, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func videoLike(
//        video_uid: Int?,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!,
//            "video_uid": video_uid!
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .VIDEO_LIKE, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func videoVote(
//        video_uid: Int?,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!,
//            "video_uid": video_uid!
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .VIDEO_VOTE, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func videoUpload(
//        challenge_uid: Int!,
//        sub_item: String!,
//        title: String!,
//        contents: String!,
//        location: String!,
//        file: Data!,
//        thumb: Data!,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!,
//            "challenge_uid": challenge_uid!,
//            "sub_item": sub_item ?? "",
//            "title": title!,
//            "contents": contents!,
//            "location": location!
//        ] as [String: AnyObject]
//        doRequestForFile(method: .post, api: .VIDEO_UPLOAD, imgArray: [thumb], imgMark: "thumbnail", vidArray: [file], vidMark: "video", params: params as [String: AnyObject], success: success, failure: failure)
//    }
//    
//    public static func videoDetail(
//        video_uid: Int!,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!,
//            "video_uid": video_uid!
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .VIDEO_DETAIL, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func videoAddComment(
//        video_uid: Int!,
//        contents: String!,
//        parent_uid: Int!,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!,
//            "video_uid": video_uid!,
//            "contents": contents!,
//            "parent_uid": parent_uid!
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .VIDEO_ADD_COMMENT, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func commentDetail(
//        comment_uid: Int!,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!,
//            "comment_uid": comment_uid!
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .VIDEO_COMMENT_DETAIL, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func driveStart(
//        start_latitude: Double!,
//        start_longitude: Double!,
//        start_point: String!,
//        end_latitude: Double!,
//        end_longitude: Double!,
//        end_point: String!,
//        distance: Int!,
//        drive_uid: Int!,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!,
//            "start_latitude": start_latitude!,
//            "start_longitude": start_longitude!,
//            "start_point": start_point!,
//            "end_latitude": end_latitude!,
//            "end_longitude": end_longitude!,
//            "end_point": end_point!,
//            "distance": distance!,
//            "drive_uid": drive_uid!
//        ] as [String: AnyObject]
//        doRequest(method: .post, api: .DRIVE_START, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func driveStop(
//        drive_uid: Int!,
//        end_latitude: Double!,
//        end_longitude: Double!,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!,
//            "drive_uid": drive_uid!,
//            "end_latitude": end_latitude!,
//            "end_longitude": end_longitude!
//        ] as [String: AnyObject]
//        doRequest(method: .post, api: .DRIVE_STOP, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func shopItemList(
//        sort: String!,
//        page: Int!,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!,
//            "sort": sort!,
//            "page": page!
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .SHOP_ITEM_LIST, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func shopItemDetail(
//        product_uid: Int!,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!,
//            "product_uid": product_uid!
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .SHOP_ITEM_DETAIL, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func shopItemBuy(
//        product_uid: Int!,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!,
//            "product_uid": product_uid!
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .SHOP_ITEM_BUY, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func reportList(
//        page: Int!,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!,
//            "page": page!
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .REPORT_LIST, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func report(
//        report: String!,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!,
//            "report": report!
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .REPORT, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func gainStone(
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .GAIN_STONE, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func updateVisitCnt(
//        videoUid: Int!,
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        let params = [
//            "access_token": user.access_token!,
//            "video_uid": videoUid!
//        ] as [String: AnyObject]
//
//        doRequest(method: .post, api: .UPDATE_VISIT_CNT, params: params, header: [:], success: success, failure: failure)
//    }
//    
//    public static func norWordList(
//        success: SuccessBlock?,
//        failure: FailureBlock?
//    ) {
//        doRequest(method: .post, api: .NO_WORD_LIST, params: [:], header: [:], success: success, failure: failure)
//    }
//    
    public static func loadMyInfo(
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "access_token": user.access_token!
        ] as [String: AnyObject]

        doRequest(method: .post, api: .MY_INFO, params: params, header: [:], success: success, failure: failure)
    }
    
    public static func getAskList(
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "access_token": user.access_token!
        ] as [String: AnyObject]

        doRequest(method: .post, api: .ASK_LIST, params: params, header: [:], success: success, failure: failure)
    }
    
    public static func getNoticeList(
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "access_token": user.access_token!
        ] as [String: AnyObject]

        doRequest(method: .post, api: .GET_NOTICE_LIST, params: params, header: [:], success: success, failure: failure)
    }
    
    public static func getNotice(
        noticeID: Int,
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "id": noticeID,
            "access_token": user.access_token!
        ] as [String: AnyObject]

        doRequest(method: .post, api: .VIEW_NOTICE, params: params, header: [:], success: success, failure: failure)
    }
    
    public static func getFAQList(
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "access_token": user.access_token!
        ] as [String: AnyObject]

        doRequest(method: .post, api: .FAQ_LIST, params: params, header: [:], success: success, failure: failure)
    }
    
    public static func getFAQCategoryList(
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "access_token": user.access_token!
        ] as [String: AnyObject]

        doRequest(method: .post, api: .FAQ_CATE, params: params, header: [:], success: success, failure: failure)
    }
    
    public static func getVersionInfo(
        success: SuccessBlock?,
        failure: FailureBlock?
    ) {
        let params = [
            "platform": 1
        ] as [String: AnyObject]

        doRequest(method: .post, api: .VERSION, params: params, header: [:], success: success, failure: failure)
    }
}
