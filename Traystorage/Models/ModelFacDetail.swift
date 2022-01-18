import Foundation
import SwiftyJSON

public class ModelFacDetail: ModelBase {
    var facInfo: ModelFac! // 구장정보
    var picInfo = [ModelPicInfo?]() // 매장상세 이미지 목록
    var facGroup = [ModelFacGroup?]() // 연관 구장    (현재 구장 포함, 구장UID가 같으면 해당 구장이 선택된것으로 처리필요)
    
    var facAd: String! // 매장광고(HTML)
    var teamCnt: Int! // 팀수??
    
    // 구장 가상계좌 결제일떄 필요
    var vbankBankCode: String! // 가상계좌 은행코드
    var vbankBankName: String! // 가상계좌 은행명
    var vbankNum: String! // 가상계좌 계좌번호
    var vbankExpDate: String! // 가상계좌 만료날짜
    
    //구장상세에서 결제하기위해 필요한 정보들
    var start_date: String! // 날짜//2021-12-07,
    var start_time: String! // 시작시간//18:00,
    var time_length: Int! // 시간길이(분단위)//60,
    var totalPrice: Int! // 가격
    var schedule_num: String! // 스케쥴번호
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        facInfo = ModelFac(json["facInfo"])
        
        let arr = json["picInfo"]
        if arr != .null {
            for (_, m) in arr {
                picInfo.append(ModelPicInfo(m))
            }
        }
        
        let arr1 = json["facGroup"]
        if arr1 != .null {
            for (_, m) in arr1 {
                facGroup.append(ModelFacGroup(m))
            }
        }
        
        facAd = json["facAd"].stringValue
        teamCnt = json["teamCnt"].intValue
        
        vbankBankCode = json["vbankBankCode"].stringValue
        vbankBankName = json["vbankBankName"].stringValue
        vbankNum = json["vbankNum"].stringValue
        vbankExpDate = json["vbankExpDate"].stringValue
        
        start_date = json["start_date"].stringValue
        start_time = json["start_time"].stringValue
        time_length = json["time_length"].intValue
        totalPrice = json["totalPrice"].intValue
        schedule_num = json["schedule_num"].stringValue
    }
}

public class ModelPicInfo: ModelBase {
    var pNum: String! //
    var pName: String! //
    var pUrl: String! // 이미지URL
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        
        pNum = json["pNum"].stringValue
        pName = json["pName"].stringValue
        pUrl = json["pUrl"].stringValue
    }
}

public class ModelFacGroup: ModelBase {
    var fNum: String! // 구장UID
    var fName: String! // 간단구장명
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        fNum = json["fNum"].stringValue
        fName = json["fName"].stringValue
    }
}
