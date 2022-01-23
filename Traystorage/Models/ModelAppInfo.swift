import Foundation
import SwiftyJSON

public class ModelAppInfo: ModelBase {
    var license: String!
    var privacy: String!
    var background_img: String!
    var challenge_img: String!
    var drive_img: String!
    var live_img: String!
    
    override init(_ json: JSON) {
        super.init(json)
        license = json["license"].stringValue
        privacy = json["privacy"].stringValue
        background_img = json["background_img"].stringValue
        challenge_img = json["challenge_img"].stringValue
        drive_img = json["drive_img"].stringValue
        live_img = json["live_img"].stringValue
    }
}
