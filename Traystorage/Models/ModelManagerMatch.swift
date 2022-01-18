import Foundation
import SwiftyJSON

public class ModelManagerMatch: ModelBase {
    var s_match_attend_num: String! // 매치참여UID
    var pNum: String! // 회원UID(0인경우 실력평가 및 매너평가 불가)
    var team_index: Int! // 팀번호(0~4, 0이면 팀선택안됨)
    var vest_num: String! // 팀내 order
    var name: String! // 이름
    var lev: Int! // 실력점수(Float형), 없으면 null
    var lev_now: Int! // 현재매치에서의 실력점수(Float형), 없으면 null
    var manner: String! // 매너삭감index(", "로 구분됨), 없으면 null
    var manner_now: String! // 현재매치에서의 매너삭감index(", "로 구분됨), 없으면 null

    override init() {
        super.init()
    }

    override init(_ json: JSON) {
        super.init(json)
        
        s_match_attend_num = json["s_match_attend_num"].stringValue
        pNum = json["pNum"].stringValue
        team_index = json["team_index"].intValue
        vest_num = json["vest_num"].stringValue
        name = json["name"].stringValue
        lev = json["lev"].intValue
        lev_now = json["lev_now"].intValue
        manner = json["manner"].stringValue
        manner_now = json["manner_now"].stringValue
    }
}

public class ModelManagerMatchEntry: ModelBase {
    var list = [ModelManagerMatch?]()

    override init() {
        super.init()
    }

    override init(_ json: JSON) {
        super.init(json)

        let arr = json["contents"]
        if arr != .null {
            for (_, m) in arr {
                list.append(ModelManagerMatch(m))
            }
        }
    }
}
