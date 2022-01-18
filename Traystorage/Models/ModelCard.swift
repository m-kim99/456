import Foundation
import SwiftyJSON

public class ModelCard: ModelBase {
    var creditcard_num: String! //카드UID
    var nickname: String! //카드별칭
    var cardname: String! //카드사명
    var cardno: String! // 카드사번호
    var false_count: String! // 실패횟수(사용안함)
    var last_yn: String! // //마지막에 사용한 카드여부(y,n) 모두n이거나 아니면  y로 내려옴
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        creditcard_num = json["creditcard_num"].stringValue
        nickname = json["nickname"].stringValue
        cardname = json["cardname"].stringValue
        cardno = json["cardno"].stringValue
        false_count = json["false_count"].stringValue
        last_yn = json["last_yn"].stringValue
    }
}


public class ModelCardList: ModelBase {
    var list = [ModelCard?]()
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        
        let arr = json["contents"]
        if arr != .null {
            for (_, m) in arr {
                list.append(ModelCard(m))
            }
        }
    }
}
