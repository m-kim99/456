//
//  Global.swift
//  Log
//
//  Created by Point on 10/28/19.
//  Copyright © 2019 dev. All rights reserved.
//

import Foundation
import UIKit

var gMeInfo = SnsUserInfo()

// ------------------------------
// Typedef
// ------------------------------

public enum SnsType: Int {
  case Naver = 1
  case Kakao = 2
  
  var value: Int {
    return self.rawValue
  }
}

public enum SnsGenderType: Int {
  case Man = 1
  case Woman = 2

  var value: Int {
    return self.rawValue
  }
  
  var string: String {
    switch self {
    case .Man:
      return "M"
    default:
      return "W"
    }
  }
}

// naver key
let kConsumerKey = "3yTy686Cp90AhtnddKXr"
let kConsumerSecret = "NXtDpIUvYI"
let kServiceAppUrlScheme = "iamground"

