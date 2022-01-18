import Foundation
import SwiftyJSON

public class ModelStadium: ModelBase {
    var uid: Int!
    var name: String!
    var out_yn: String!
    var latitude: String!
    var longitude: String!
    var size: Int!
    var floor_material: String!
    var park_yn: String!
    var warm_air_yn: String!
    var bath_yn: String!
    var ball_yn: String!
    var uniform_yn: String!
    var footwear_yn: String!
    var new_yn: String!
    var recent_yn: String!
    var reserv = [ModelReserve?]()
    
    override init() {
        super.init()
    }
    
    init(dumyIndex: Int!) {
        super.init()
        uid = dumyIndex
        
        if dumyIndex % 3 == 0 {
            name = "Welcome to our stadium"
            out_yn = "y"
            size = 3
            floor_material = "aspalt"
            park_yn = "y"
            latitude = "37.7074072"
            longitude = "126.146652"
            warm_air_yn = "y"
            ball_yn = "y"
            bath_yn = "y"
            uniform_yn = "y"
            footwear_yn = "y"
            new_yn = "y"
            recent_yn = "y"
        } else if dumyIndex % 3 == 1 {
            name = "Welcome to our stadium"
            out_yn = "n"
            size = 5
            floor_material = "aspalt"
            park_yn = "n"
            warm_air_yn = "n"
            latitude = "37.7074072"
            longitude = "126.146652"
            ball_yn = "n"
            bath_yn = "n"
            uniform_yn = "n"
            footwear_yn = "n"
            new_yn = "n"
            recent_yn = "n"
        } else {
            name = "Welcome to our stadium"
            out_yn = "y"
            size = 1
            floor_material = "aspalt"
            park_yn = "y"
            latitude = "37.7074072"
            longitude = "126.146652"
            warm_air_yn = "y"
            ball_yn = "n"
            bath_yn = "y"
            uniform_yn = "1"
            footwear_yn = "y"
            new_yn = "y"
            recent_yn = "y"
        }
        
        var reservList = [ModelReserve?]()
        for i in 0..<4 {
            let reservModel = ModelReserve(dumyIndex: i)
            reservList.append(reservModel)
        }
        
        reserv = reservList
    }
}
