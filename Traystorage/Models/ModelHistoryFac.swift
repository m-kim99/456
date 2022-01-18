import Foundation
import SwiftyJSON

public class ModelHistoryFac: ModelBase {
    var rNum: String! // 예약UID
    var request_time: String! // 주문요청시간
    var sDate: String! // 예약날짜
    var day: Int! // 예약날짜요일(0-일요일,6-토요일)
    var sTime: String! // 예약시작시간
    var eTime: String! // 예약종료시간
    var price: Int! // 가격
    var pNum: String! // 회원UID
    var fNum: String! // 구장UID
    var fName: String! // 구장명
    var fac_image: String! // 구장이미지
    var fTel: String! //
    var tName: String! // 팀명
    var tel: String! // 구장연락처
    var picName: String! //
    var paymentMethod: String! // 결제형태(CARD,VBANK,BANK,COUPON) --- (BANK,COUPON은 현재 사용하지 않지만 기존이력이 있을 수 있음)
    var event_callback: String! //
    var method: String! // 실제결제방법(CARD,VBANK,BANK)
    var receipt_url: String! // 영수증URL(method=CARD,VBANK인 경우에만 값이 있음)
    var paymentID: String! // 결제트랜잭션ID
    var bank: String! // 은행명(가상계좌결제의 경우)
    var account: String! // 계좌번호(가상계좌결제의 경우)
    var account_name: String! // 예금주명(가상계좌결제의 경우)
    var state: Int! // -5~2 (자세한내용은 API참고문서 참고)
    var state_str: String! // 예약상태문자열
    var expired_yn: String! // 대관예약시간 만료여부(y,n)
    var retain_days: Int! // 예약날짜까지 남은 날짜

    override init() {
        super.init()
    }

    override init(_ json: JSON) {
        super.init(json)
        rNum = json["rNum"].stringValue
        request_time = json["request_time"].stringValue
        sDate = json["sDate"].stringValue
        day = json["day"].intValue
        sTime = json["sTime"].stringValue
        eTime = json["eTime"].stringValue
        price = json["price"].intValue
        pNum = json["pNum"].stringValue
        fNum = json["fNum"].stringValue
        fName = json["fName"].stringValue
        fac_image = json["fac_image"].stringValue
        fTel = json["fTel"].stringValue
        tName = json["tName"].stringValue
        tel = json["tel"].stringValue
        picName = json["picName"].stringValue
        paymentMethod = json["paymentMethod"].stringValue
        event_callback = json["event_callback"].stringValue
        method = json["method"].stringValue
        receipt_url = json["receipt_url"].stringValue
        paymentID = json["paymentID"].stringValue
        bank = json["bank"].stringValue
        account = json["account"].stringValue
        account_name = json["account_name"].stringValue
        state = json["state"].intValue
        state_str = json["state_str"].stringValue
        expired_yn = json["expired_yn"].stringValue
        retain_days = json["retain_days"].intValue
    }
}

public class ModelHistoryFacList: ModelBase {
    var list = [ModelHistoryFac?]()

    override init() {
        super.init()
    }

    override init(_ json: JSON) {
        super.init(json)

        let arr = json["contents"]
        if arr != .null {
            for (_, m) in arr {
                list.append(ModelHistoryFac(m))
            }
        }
    }
}
