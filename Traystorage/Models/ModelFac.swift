import Foundation
import SwiftyJSON

public class ModelFac: ModelBase {
    var fNum: String! //   시설 번호
    var fName: String! //    시설 이름
    var fAddress: String! //  시설 주소
    var longitude: Double! //   경도
    var latitude: Double! //   위도
    var forecast_Y: String! //
    var forecast_X: String! //
    var sNum: String! //  구 나눔 번호
    var pNum: Int! //  사진 갯수
    var fTel: String! //  전화번호
    var homepage: String! //  홈페이지
    var r_implement: String! //   예약 방식
    var r_unit: String! //   예약 단위
    var co: String! //  제휴 여부
    var size: String! //   규격(가로 * 세로)
    var size2: String! //
    var capacity: Int! //
    var floor: String! //  바닥재(인조잔디, 천연잔디, 플라스틱, 모래)
    var parking: String! //  주차장(있음, 없음)
    var shower: String! //  샤워시설(있음, 없음)
    var indoor: String! //   실내여부(있음, 없음)
    var temp: String! //  냉난방(X-없음, 그외는 그대로 표시)
    var ballrent: String! //   공대여(있음, 없음)
    var vestrent: String! //   조끼대여(있음, 없음)
    var shoesrent: String! //   풋살화대여(있음, 없음)
    var lighting: String! //  조명(있음, 없음)
    var light_price: String! //   조명 가격(포함, 별도, 없음)
    var note: String! //  비고
    var fac_image: String! // 경기장이미지
    var price_dd: Int! //  가격(주중주간, 비어있으면 모르거나 운행하지 않다는 뜻)
    var price_dn: Int! //   가격(주중야간,)
    var price_ed: Int! //  가격(주말주간)
    var price_en: Int! //  가격(주말야간)
    var new_yn: String! // 새로추가됨
    var recent_yn: String! // 최근 예약함
    
    // 상세페서
    var pay_bank: String! // 계좌이체 결제가능(O,X) -->사용안해도 됨
    var pay_card: String! // 신용카드 결제가능(O,X)
    var pay_vbank: String! // 가상계좌 결제가능(O,X)
    var useRule: String! //
    var notice: String! //
    var payRule: String! //
    
    var reservlist = [ModelReserv?]() // 제휴시설(co=O)에 대해서만 값이 있음, 30일 예약정보(Array), 빠진 시간대는 예약불가
    var reservSellist = [ModelReserv?]() //
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        fNum = json["fNum"].stringValue
        fName = json["fName"].stringValue
        fAddress = json["fAddress"].stringValue
        longitude = json["longitude"].doubleValue
        latitude = json["latitude"].doubleValue
        forecast_Y = json["forecast_Y"].stringValue
        forecast_X = json["forecast_X"].stringValue
        sNum = json["sNum"].stringValue
        pNum = json["pNum"].intValue
        fTel = json["fTel"].stringValue
        homepage = json["homepage"].stringValue
        r_implement = json["r_implement"].stringValue
        r_unit = json["r_unit"].stringValue
        co = json["co"].stringValue
        size = json["size"].stringValue
        size2 = json["size2"].stringValue
        capacity = json["capacity"].intValue
        floor = json["floor"].stringValue
        parking = json["parking"].stringValue
        shower = json["shower"].stringValue
        indoor = json["indoor"].stringValue
        temp = json["temp"].stringValue
        ballrent = json["ballrent"].stringValue
        vestrent = json["vestrent"].stringValue
        shoesrent = json["shoesrent"].stringValue
        lighting = json["lighting"].stringValue
        light_price = json["light_price"].stringValue
        note = json["note"].stringValue
        fac_image = json["fac_image"].stringValue
        price_dd = json["price_dd"].intValue
        price_dn = json["price_dn"].intValue
        price_ed = json["price_ed"].intValue
        price_en = json["price_en"].intValue
        new_yn = json["new_yn"].stringValue
        recent_yn = json["recent_yn"].stringValue
        
        pay_bank = json["pay_bank"].stringValue
        pay_card = json["pay_card"].stringValue
        pay_vbank = json["pay_vbank"].stringValue
        useRule = json["useRule"].stringValue
        notice = json["notice"].stringValue
        payRule = json["payRule"].stringValue
        
        let arr = json["reserv"]
        if arr != .null {
            for (_, m) in arr {
                reservlist.append(ModelReserv(m))
            }
        }
    }
}

public class ModelReserv: ModelBase {
    var schedule_num: String! // 스케쥴번호  //14897026,
    var note: String! // 비고
    var start_date: String! // 날짜//2021-12-07,
    var start_time: String! // 시작시간//18:00,
    var end_time: String! // 끝시간//19:00,
    var time_length: Int! // 시간길이(분단위)//60,
    var unit_price: Int! // 가격 //45000,
    var date_offset: String! // 당일날짜기준 차이날짜//20
    
    var select = false
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        schedule_num = json["schedule_num"].stringValue
        note = json["note"].stringValue
        start_date = json["start_date"].stringValue
        start_time = json["start_time"].stringValue
        end_time = json["end_time"].stringValue
        time_length = json["time_length"].intValue
        unit_price = json["unit_price"].intValue
        date_offset = json["date_offset"].stringValue
    }
}

public class ModelFacList: ModelBase {
    var list = [ModelFac?]()
    
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        
        let arr = json["contents"]
        if arr != .null {
            for (_, m) in arr {
                list.append(ModelFac(m))
            }
        }
    }
}
