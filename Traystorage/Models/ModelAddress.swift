import Foundation
import SwiftyJSON

public class ModelAddress: ModelBase {
    var num: Int!
    var address: String!
    var desc: String!
    var lati : String!
    var lng : String!
    
    override init() {
        super.init()
    }
    
    init(dumyIndex: Int!) {
        super.init()
        
        address = "Smile Help Center India Culture Center"
        desc = "Smile Help Center India Culture Center"
        num = dumyIndex
    }
}
