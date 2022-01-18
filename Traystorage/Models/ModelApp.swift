import Foundation
import SwiftyJSON

public class ModelApp: ModelBase {
    var upgrade_url: String! //업그레이드 URL
    var version_name: String! //버전명
    var review_version_code: String! //앱스토어 심사중 버전코드
    var popup_info : ModelPopupInfo!
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        upgrade_url = json["upgrade_url"].stringValue
        version_name = json["version_name"].stringValue
        review_version_code = json["review_version_code"].stringValue
        popup_info = ModelPopupInfo(json["popup_info"])
    }
}


public class ModelPopupInfo: ModelBase {
    var type: String! //팝업타입(image/html)
    var popup_url: String! //이미지혹은 링크 URL
    var target_type: String! //클릭시 이동할 타입(fut/bsk/s_match/url)
    var target_value: String! //fNum 혹은 외부링크(빈문자열이면 이동안함)
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        type = json["type"].stringValue
        popup_url = json["popup_url"].stringValue
        target_type = json["target_type"].stringValue
        target_value = json["target_value"].stringValue
    }
}
