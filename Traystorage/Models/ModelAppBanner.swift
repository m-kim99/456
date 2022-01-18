import Foundation
import SwiftyJSON

public class ModelAppBanner: ModelBase {
    var banner_uid: Int! //배너UID
    var image_url: String! //이미지 URL
    var target_type: String! //클릭시 이동할 타입(fut/bsk/s_match/url)
    var target_value: String! // fNum 혹은 외부링크(빈문자열이면 이동안함)
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        banner_uid = json["banner_uid"].intValue
        image_url = json["image_url"].stringValue
        target_type = json["target_type"].stringValue
        target_value = json["target_value"].stringValue
    }
}

public class ModelAppBannerList: ModelBase {
    var list = [ModelAppBanner?]()
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        
        let arr = json["contents"]
        if arr != .null {
            for (_, m) in arr {
                list.append(ModelAppBanner(m))
            }
        }
    }
}
