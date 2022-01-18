import Foundation
import SwiftyJSON

public class ModelMatch: ModelBase {
    var uid: Int!
    var name: String!
    var start_date: String!
    var start_time: String!
    var latitude: String!
    var longitude: String!
    var end_time: String!
    var gender: String!
    var size: Int!
    var parking: String!
    var status: String!
    var new_yn: String!
    
    override init() {
        super.init()
    }
    
    
    init(dumyIndex: Int!) {
        super.init()
        uid = dumyIndex
        
        if dumyIndex % 3 == 0 {
            start_date = "11/30(Sat)"
            start_time = "08:00"
            end_time = "10:00"
            new_yn = "y"
            latitude = "37.7074072"
            longitude = "126.146652"
            gender = "male"
            size = 5
            parking = "free"
            name = "Beijing new Match text text item"
            status = "imminent"
        } else if dumyIndex % 3 == 1 {
            start_date = "11/6(Sun)"
            start_time = "06:00"
            end_time = "08:00"
            new_yn = "y"
            latitude = "37.7074072"
            longitude = "126.146652"
            gender = "female"
            size = 6
            parking = "paid"
            name = "Canada new Match item"
            status = "involved"
        } else {
            start_date = "12/16(Mon)"
            start_time = "08:00"
            end_time = "10:00"
            new_yn = "n"
            latitude = "37.7074072"
            longitude = "126.146652"
            gender = "male"
            size = 1
            parking = "no"
            name = "London new Match item"
            status = "deadline"
        }
    }
}
