//
//  Connectivity.swift
//  OMDb
//
//  Created by Ruchi Gadge on 06/07/18.
//  Copyright © 2018 Ruchi Gadge. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
