import Foundation
import SwiftyJSON

public class ModelBanner: ModelBase {
    var uid: Int!
    var link_type: String!
    var link_content: String!
    var img: String!
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        uid = json["uid"].intValue
        link_type = json["link_type"].stringValue
        link_content = json["link_content"].stringValue
        img = json["img"].stringValue
    }
}
