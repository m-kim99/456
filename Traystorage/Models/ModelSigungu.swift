import Foundation
import SwiftyJSON

public class ModelSigungu: ModelBase {
    var sido: String! //도시명
    var name: String! //군구명
    var latitude: String! //위도
    var longitude: String! // 경도
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        sido = json["sido"].stringValue
        name = json["name"].stringValue
        latitude = json["latitude"].stringValue
        longitude = json["longitude"].stringValue
    }
}


public class ModelSigunguList: ModelBase {
    var list = [ModelSigungu?]()
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        
        let arr = json["contents"]
        if arr != .null {
            for (_, m) in arr {
                list.append(ModelSigungu(m))
            }
        }
    }
}
