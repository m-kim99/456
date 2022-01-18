import Foundation
import SwiftyJSON

public class ModelSMatchDetail: ModelBase {
    var s_match_num: String! // 매치UID
    var start_date: String! // 시작날짜(YYYY-MM-DD)
    var start_time: String! // 시작시간(HH:MM:DD)
    var time_length: Int! // 매치진행시간(분)
    var fNum: String! // 구장UID
    var manager_num: String! // 매니저유저UID
    var min_cap: Int! // 최소인원
    var max_cap: Int! // 최대인원
    var rule: Int! // 매치인원(5이면 5 vs 5)
    var gender_type: Int! // 매치성별(1-남,2-여)
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
    var is_active: Int! // 매치진행여부(0,1)
    var fName: String! // 구장명
    var fAddress: String! // 구장주소
    var longitude: Double! // 구장위도
    var latitude: Double! // 구장경도
    var size: String! //
    var manager_nickname: String! // 매니저유저 닉네임
    var nowcapacity: Int! // 남은인원
    var vaccnt: Int! // 참여자중 백신미접종수
    var vac_limit_cnt: Int! // 백신미접종자수 남은자리(0또는 0보다 작은값이면 백신미접종자는 참여불가)
    var already: Int! // 0이면 참여안함 0이상이면 이미 매치참여함
    var event_end: Int! // 해당구장 풋살매치진행수(0이면 NEW)
    var request_time: String! //
    var match_status: String! // 매치상태 (done: 모집완료, notice-deadline: 마감임박, playing: 경기진행중, close: 경기완료, available: 참여가능)
    var detail_info_long: String! // 상세안내(HTML)
    var refund_rule: String! // 환불규정(HTML)
    var userule_common: String! // 이용안내공통(HTML) ==>이용안내는 "이용안내공통 + 이용안내추가" HTML로 표기
    var userule_add: String! // 이용안내추가(HTML)
    var price: Int! // 결제가격
    var manager_profile: String! // 매니저프로필이미지
    var smatch_image: String! // 매치이미지
    var rule_alert: String! // 공지사항(\n으로 구분하여 표시)

    override init() {
        super.init()
    }

    override init(_ json: JSON) {
        super.init(json)

        s_match_num = json["info"]["s_match_num"].stringValue
        start_date = json["info"]["start_date"].stringValue
        start_time = json["info"]["start_time"].stringValue
        time_length = json["info"]["time_length"].intValue
        fNum = json["info"]["fNum"].stringValue
        manager_num = json["info"]["manager_num"].stringValue
        min_cap = json["info"]["min_cap"].intValue
        max_cap = json["info"]["max_cap"].intValue
        rule = json["info"]["rule"].intValue
        gender_type = json["info"]["gender_type"].intValue
        lev_type = json["info"]["lev_type"].stringValue
        subway = json["info"]["subway"].stringValue
        park = json["info"]["park"].stringValue
        water = json["info"]["water"].stringValue
        uniform = json["info"]["uniform"].stringValue
        shoes = json["info"]["shoes"].stringValue
        detail_info = json["info"]["detail_info"].stringValue
        userule_info = json["info"]["userule_info"].stringValue
        payrule_info = json["info"]["payrule_info"].stringValue
        manager_ready = json["info"]["manager_ready"].stringValue
        is_active = json["info"]["is_active"].intValue
        fName = json["info"]["fName"].stringValue
        fAddress = json["info"]["fAddress"].stringValue
        longitude = json["info"]["longitude"].doubleValue
        latitude = json["info"]["latitude"].doubleValue
        size = json["info"]["size"].stringValue
        manager_nickname = json["info"]["manager_nickname"].stringValue
        nowcapacity = json["info"]["nowcapacity"].intValue
        vaccnt = json["info"]["vaccnt"].intValue
        vac_limit_cnt = json["info"]["vac_limit_cnt"].intValue
        already = json["info"]["already"].intValue
        event_end = json["info"]["event_end"].intValue
        request_time = json["info"]["request_time"].stringValue
        match_status = json["info"]["match_status"].stringValue
        detail_info_long = json["info"]["detail_info_long"].stringValue
        refund_rule = json["info"]["refund_rule"].stringValue
        userule_common = json["info"]["userule_common"].stringValue
        userule_add = json["info"]["userule_add"].stringValue
        price = json["info"]["price"].intValue
        manager_profile = json["info"]["manager_profile"].stringValue
        smatch_image = json["info"]["smatch_image"].stringValue
        rule_alert = json["info"]["rule_alert"].stringValue
    }
}
