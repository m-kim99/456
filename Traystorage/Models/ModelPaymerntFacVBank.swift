import Foundation
import SwiftyJSON

public class ModelPaymerntFacVBank: ModelBase {
    var vbankBankCode: String! // 가상계좌 은행코드
    var vbankBankName: String! // 가상계좌 은행명
    var vbankNum: String! // 가상계좌 계좌번호
    var vbankExpDate: String! // 가상계좌 만료날짜

    override init() {
        super.init()
    }

    override init(_ json: JSON) {
        super.init(json)
        vbankBankCode = json["vbankBankCode"].stringValue
        vbankBankName = json["vbankBankName"].stringValue
        vbankNum = json["vbankNum"].stringValue
        vbankExpDate = json["vbankExpDate"].stringValue
    }
}
