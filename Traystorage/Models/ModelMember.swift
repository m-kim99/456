import Foundation
import SwiftyJSON

public class ModelMember {
    var uid: Int!
    var name: String!
    var stadium_name: String!
    var group_index: Int!
    var evaluation_score: Int!
    var manner_score: Int!

//    override init(_ json: JSON) {
//        super.init(json)
//        uid = json["uid"].intValue
//        name = json["name"].stringValue
//        stadium_name = json["stadium_name"].stringValue
//        group_index = json["group_index"].intValue
//        evaluation_score = json["evaluation_score"].intValue
//        manner_score = json["manner_score"].intValue
//    }
    
    init(uid: Int, name: String, stadium_name: String, group_index: Int, evaluation_score: Int, manner_score: Int) {
        self.uid = uid
        self.name = name
        self.stadium_name = stadium_name
        self.group_index = group_index
        self.evaluation_score = evaluation_score
        self.manner_score = manner_score
    }
}
