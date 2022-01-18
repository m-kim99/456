import Foundation
import SwiftyJSON

public class ModelCancelFacInfo: ModelBase {
    var refund_info: ModelRefundInfo! // 환불정보
    var resv_info: ModelResvInfo! // 예약정보
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        refund_info = ModelRefundInfo(json["refund_info"])
        resv_info = ModelResvInfo(json["resv_info"])
    }
}

public class ModelRefundInfo: ModelBase {
    var sDay: String! //
    var eDay: String! //
    var refundPercent: Int! // 환불퍼센트(0~100)
    var toChk: String! //
    var totalPrice: Int! // 전체결제금액
    var paymentID: String! // 결제트랜잭션ID
    var paymentMethod: String! // 결제방식(CARD,VBANK,BANK,COUPON)
    var refundPrice: Int! // 환불가능금액
    var changedCount: Int! // 변경횟수(1이상이면 환불불가)
    var productCode: String! // 상품코드
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        sDay = json["sDay"].stringValue
        eDay = json["eDay"].stringValue
        refundPercent = json["refundPercent"].intValue
        toChk = json["toChk"].stringValue
        totalPrice = json["totalPrice"].intValue
        paymentID = json["paymentID"].stringValue
        paymentMethod = json["paymentMethod"].stringValue
        refundPrice = json["refundPrice"].intValue
        changedCount = json["changedCount"].intValue
        productCode = json["productCode"].stringValue
    }
}

public class ModelResvInfo: ModelBase {
    var fNum: String! // 구장UID
    var fName: String! // 구장명
    var sDate: String! // 예약날짜
    var sTime: String! // 예약시작시간
    var eTime: String! // 예약종료시간
    var pNum: String! // 회원UID
    var pName: String! // 회원명
    var adminTel: String! // 담당자폰번호
    var ID: String! // 담당자카톡아이디??
    var tNum: String! // 팀번호
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        fNum = json["fNum"].stringValue
        fName = json["fName"].stringValue
        sDate = json["sDate"].stringValue
        sTime = json["sTime"].stringValue
        eTime = json["eTime"].stringValue
        pNum = json["pNum"].stringValue
        pName = json["pName"].stringValue
        adminTel = json["adminTel"].stringValue
        ID = json["ID"].stringValue
        tNum = json["tNum"].stringValue
    }
}
