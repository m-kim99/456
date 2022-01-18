import Foundation
import SwiftyJSON

public class ModelSMatch: ModelBase {
    var s_match_num: Int! // 매치UID
    var start_date: String! // 시작날짜(YYYY-MM-DD)
    var start_time: String! // 시작시간(HH:MM:DD)
    var time_length: Int! // 매치진행시간(분)
    var fNum: String! // 구장UID
    var manager_num: String! // 매니저유저UID
    var min_cap: Int! // 최소인원
    var max_cap: Int! // 최대인원
    var rule: String! // 매치인원(5이면 5 vs 5)
    var gender_type: String! // 매치성별(1-남,2-여)
    var lev_type: String! //
    var subway: String! //
    var park: String! // 무료/유료/X
    var water: String! // 물제공(O/X)
    var uniform: String! // 운동복대여(O/X)
    var shoes: String! // 풋살화대여(O/X)
    var detail_info: String! //
    var userule_info: String! //
    var payrule_info: String! //
    var manager_ready: String! //
    var is_active: String! // 매치진행여부(0,1)
    var fName: String! // 구장명
    var fAddress: String! // 구장주소
    var longitude: String! // 구장위도
    var latitude: String! // 구장경도
    var nowcapacity: Int! // 남은인원
    var event_end: String! // 해당구장 풋살매치진행수(0이면 NEW)
    var request_time: String! //
    var match_status: String! // 매치상태 (done: 모집완료, notice-deadline: 마감임박, playing: 경기진행중, close: 경기완료, available: 참여가능)
    var manager_profile: String! // 매니저프로필이미지
    var smatch_image: String! // 매치이미지
    var rule_alert: String! // 공지사항(\n으로 구분하여 표시)

    // 추가필드. 에약 시
    var day: Int! // 예약날짜요일(0-일요일,6-토요일)
    var retain_days: Int! // 예약날짜까지 남은 날짜
    var classs: String! // 경기진행상태(cancel: 취소됨, stand-by: 대기중, done: 완료)
    var totalPrice: Int! // 결제가격
    var s_match_attend_num: String! // 매치참여UID
    var refund_percent: Float! // 환불퍼센트(0.0 ~ 1.0)

    override init() {
        super.init()
    }

    override init(_ json: JSON) {
        super.init(json)

        s_match_num = json["s_match_num"].intValue
        start_date = json["start_date"].stringValue
        start_time = json["start_time"].stringValue
        time_length = json["time_length"].intValue
        fNum = json["fNum"].stringValue
        manager_num = json["manager_num"].stringValue
        min_cap = json["min_cap"].intValue
        max_cap = json["max_cap"].intValue
        rule = json["rule"].stringValue
        gender_type = json["gender_type"].stringValue
        lev_type = json["lev_type"].stringValue
        subway = json["subway"].stringValue
        park = json["park"].stringValue
        water = json["water"].stringValue
        uniform = json["uniform"].stringValue
        shoes = json["shoes"].stringValue
        detail_info = json["detail_info"].stringValue
        userule_info = json["userule_info"].stringValue
        payrule_info = json["payrule_info"].stringValue
        manager_ready = json["manager_ready"].stringValue
        is_active = json["is_active"].stringValue
        fName = json["fName"].stringValue
        fAddress = json["fAddress"].stringValue
        longitude = json["longitude"].stringValue
        latitude = json["latitude"].stringValue
        nowcapacity = json["nowcapacity"].intValue
        event_end = json["event_end"].stringValue
        request_time = json["request_time"].stringValue
        match_status = json["match_status"].stringValue
        manager_profile = json["manager_profile"].stringValue
        smatch_image = json["smatch_image"].stringValue
        rule_alert = json["rule_alert"].stringValue

        day = json["day"].intValue
        retain_days = json["retain_days"].intValue
        classs = json["class"].stringValue
        totalPrice = json["totalPrice"].intValue
        s_match_attend_num = json["s_match_attend_num"].stringValue
        refund_percent = json["refund_percent"].floatValue
    }
}

public class ModelSMatchList: ModelBase {
    var list = [ModelSMatch?]()

    override init() {
        super.init()
    }

    override init(_ json: JSON) {
        super.init(json)

        let arr = json["contents"]
        if arr != .null {
            for (_, m) in arr {
                list.append(ModelSMatch(m))
            }
        }
    }
}
