import Foundation
import SwiftyJSON

public class ModelUser: ModelBase {
    var num: String! // 회원번호
    var name: String! // 이름
    var sex_code: Int! // 성별(0,1-남,2-여)
    var mail_address: String! // 메일주소
    var phone: String! // 폰번호
    var birth: String! // 생년월일
    var type: String! // 로그인타입(1-naver,2-kakao,7-apple)
    var account_key: String! // SNS ID
    var agree_send: String! // 마케팅알람 동의여부(0-미동의 1-동의)
    var last_login: String! // 가입날짜
    var unregist: String! // 회원탈퇴여부(1-탈퇴, 0-정상)
    var manager_num: String! // 매니저회원번호(null이면 일반회원, null이 아니면 매니저)
    var manager_nickname: String! // 매니저닉네임(null이면 일반회원, null이 아니면 매니저닉네임)
    var note: String! // 매니저소개문구
    var lev: Float! // 평가점수(Float형) 0이면 평가중
    var manner: Int! // 매너점수
    var resv_cnt: Int! // 구장예약횟수
    var match_cnt: Int! // 개인매치진행횟수
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        num = json["num"].stringValue
        name = json["name"].stringValue
        sex_code = json["sex_code"].intValue
        mail_address = json["mail_address"].stringValue
        phone = json["phone"].stringValue
        birth = json["birth"].stringValue
        type = json["type"].stringValue
        account_key = json["account_key"].stringValue
        agree_send = json["agree_send"].stringValue
        last_login = json["last_login"].stringValue
        unregist = json["unregist"].stringValue
        manager_num = json["manager_num"].stringValue
        manager_nickname = json["manager_nickname"].stringValue
        note = json["note"].stringValue
        lev = json["lev"].floatValue
        manner = json["manner"].intValue
        resv_cnt = json["resv_cnt"].intValue
        match_cnt = json["match_cnt"].intValue
    }
    
    static func isIdValid(_ id: String) -> Bool {
        if id.isEmpty || id.count < 4 || id.count > 16 {
            return false
        }
        
        if id.hasSpace() {
            return false
        }
        
        return true
    }
    
    static func isPasswordValid(_ pwd: String) -> Bool {
        if pwd.isEmpty || pwd.count < 8 {
            return false
        }
        
        if !pwd.hasDigit() {
            return false
        }
        
        if !pwd.hasCharacters() {
            return false
        }
        
        return true
    }
    
    static func isAuthCodeValid(code: String) -> Bool {
        if code.isEmpty || code.count != 4 {
            return false
        }
        
        return Validations.digit(code)
    }
    
    static func isBirthdayValid(birthday: String) -> Bool {
        if birthday.isEmpty || birthday.count != 6 {
            return false
        }
        
        if !Validations.digit(birthday) {
            return false
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let date = dateFormatter.date(from: birthday)!
        if date == nil {
            return false
        }
                
        return true
    }
}

public class ModelUserInfo: ModelBase {
    var info: ModelUser!
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        info = ModelUser(json["info"])
    }
}
