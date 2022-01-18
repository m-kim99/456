import Foundation
import SwiftyJSON

public class ModelManagerInfo: ModelBase {
    var seq: String! //
    var num: String! // 회원UID
    var manager_nickname: String! // 매니저닉네임
    var main_fac1: String! // 메인구장1(빈문자열일때 예외처리 필요)
    var main_fac2: String! // 메인구장2(빈문자열일때 예외처리 필요)
    var note: String! // 한줄문구
    var is_active: String! //
    var like_state: String! // 좋아요여부(0,1)
    var concept_1: String! //
    var concept_2: String! //
    var concept_3: String! //
    var match_cnt: Int! // 매치수
    var manager_profile: String! // 매니저프로필

    override init() {
        super.init()
    }

    override init(_ json: JSON) {
        super.init(json)
        seq = json["seq"].stringValue
        num = json["num"].stringValue
        manager_nickname = json["manager_nickname"].stringValue
        main_fac1 = json["main_fac1"].stringValue
        main_fac2 = json["main_fac2"].stringValue
        note = json["note"].stringValue
        is_active = json["is_active"].stringValue
        like_state = json["like_state"].stringValue
        concept_1 = json["concept_1"].stringValue
        concept_2 = json["concept_2"].stringValue
        concept_3 = json["concept_3"].stringValue
        match_cnt = json["match_cnt"].intValue
        manager_profile = json["manager_profile"].stringValue
    }
}


public class ModelManager: ModelBase {
    var info: ModelManagerInfo! //

    override init() {
        super.init()
    }

    override init(_ json: JSON) {
        super.init(json)
        info = ModelManagerInfo(json["info"])
    }
}
