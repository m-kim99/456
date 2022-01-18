import Foundation
import SwiftyJSON

public class ModelPopup: ModelBase {
    var uid: Int!
    var image: String!
    var link: String!
    var url: String!
    
    override init() {
        super.init()
    }
    
    init(dumyIndex: Int!, dumyImage: String!, dumyLink: String!, dumyUrl: String!) {
        super.init()
        uid = dumyIndex
        image = dumyImage
        link = dumyLink
        url = dumyUrl
    }
}
