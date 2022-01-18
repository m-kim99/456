import Foundation
import SwiftyJSON

public class ModelJoin: ModelBase {
    var already_num: String! // API_RESULT_ERROR_USER_ALREADY_SIGNUP 오류시 이미 가입된 회원UID
    var already_login_type: String! // API_RESULT_ERROR_USER_ALREADY_SIGNUP 오류시 이미 가입된 회원의 login_type
    var already_user_email: String! // API_RESULT_ERROR_USER_ALREADY_SIGNUP 오류시 이미 가입된 회원의 이메일

    override init() {
        super.init()
    }

    override init(_ json: JSON) {
        super.init(json)
        already_num = json["already_num"].stringValue
        already_login_type = json["already_login_type"].stringValue
        already_user_email = json["already_user_email"].stringValue
    }
}
