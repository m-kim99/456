import Foundation
import SwiftyJSON

public class ModelBase {
    var result: Int!
    var msg: String!
    var reason: String!
    
    init() {}
    
    init(_ json: JSON) {
        result = json["result"].intValue
        msg = json["msg"].stringValue
        reason = json["reason"].stringValue
    }
}

public class ModelList: ModelBase {
    var total_cnt: Int!
    var page_cnt: Int!
    var is_last: Bool!
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        
        total_cnt = json["total_cnt"].intValue
        page_cnt = json["page_cnt"].intValue
        is_last = json["is_last"].boolValue
    }
}
