import Foundation
import SwiftyJSON

public class ModelPaymentHistoryMatch: ModelBase {
    var uid: Int!
    
    override init() {
        super.init()
    }
    
    init(dumyIndex: Int!) {
        super.init()
        uid = dumyIndex
    }
}

