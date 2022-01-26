import Foundation
import SwiftyJSON

public class ModelPhoneVerify: ModelBase {
    var code: Int = -1
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        code = json["code"].intValue
    }
}
