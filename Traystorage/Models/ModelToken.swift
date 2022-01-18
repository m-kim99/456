import Foundation
import SwiftyJSON

public class ModelToken: ModelBase {
    var access_token: String! //
    var recent_fac: ModelRecentFac! //
    var recent_smatch: ModelRecentFac! //

    override init() {
        super.init()
    }

    override init(_ json: JSON) {
        super.init(json)
        access_token = json["access_token"].stringValue
        recent_fac = ModelRecentFac(json["recent_fac"])
        recent_smatch = ModelRecentFac(json["recent_smatch"])
    }
}

public class ModelRecentFac: ModelBase {
    var fNum: String! // 구장UID
    var fName: String! // 구장명
    var fAddress: String! // 구장주소
    var longitude: Double! // 구장위치_경도
    var latitude: Double! // 구장위치_위도
    var start_date: String! // 예약날짜
    var start_time: String! // 예약시간
    var park_link: String! // 구장블로그(빈문자열일 수 있음)
    var service: String! // 서비스명(fut/bsk)
    var match_cnt: Int! // 매치수
    var s_match_num: String! // 풋살매치UID

    override init() {
        super.init()
    }

    override init(_ json: JSON) {
        super.init(json)

        fNum = json["fNum"].stringValue
        fName = json["fName"].stringValue
        fAddress = json["fAddress"].stringValue
        longitude = json["longitude"].doubleValue
        latitude = json["latitude"].doubleValue
        start_date = json["start_date"].stringValue
        start_time = json["start_time"].stringValue
        park_link = json["park_link"].stringValue
        service = json["service"].stringValue
        match_cnt = json["match_cnt"].intValue
        s_match_num = json["s_match_num"].stringValue
    }
}
