import Foundation
import SwiftyJSON

public class ModelCard: ModelBase {
    var id: String! //카드UID
    var uid: String! //카드별칭
    var title: String! //카드사명
    var content: String! // 카드사번호
    var images: String! // 실패횟수(사용안함)
    var label: String! // //마지막에 사용한 카드여부(y,n) 모두n이거나 아니면  y로 내려옴
    
    var tags: String! //카드사명
    var code: String! // 카드사번호
    var create_time: String!
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        id = json["id"].stringValue
        uid = json["uid"].stringValue
        title = json["title"].stringValue
        content = json["content"].stringValue
        images = json["images"].stringValue
        label = json["label"].stringValue
        tags = json["tags"].stringValue
        code = json["code"].stringValue
        create_time = json["create_time"].stringValue
    }
}


public class ModelCardList: ModelBase {
    var list = [ModelCard?]()
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        
        let arr = json["list"]
        if arr != .null {
            for (_, m) in arr {
                list.append(ModelCard(m))
            }
        }
    }
}
