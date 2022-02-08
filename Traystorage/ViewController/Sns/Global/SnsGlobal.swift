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
  case Facebook = 3
  case Google = 4
  
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
let kConsumerKey = "DYpR8dkema6fR0FcnF0w"
let kConsumerSecret = "2iE5dYLVMn"
let kServiceAppUrlScheme = "traystorage"

let GOOGLEKEY = "1014352638153-cu0qj7mobmpl3r9iq05ftfvmf466jlll.apps.googleusercontent.com"
let GOOGLE_SCHEMA = "com.googleusercontent.apps.1014352638153-bpriac87m69h95tgjfhjc3dti2f7iefu"
