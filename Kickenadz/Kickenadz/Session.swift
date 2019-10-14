//
//  Session.swift
//  kickenadz
//
//  Created by Ryuichi Saito on 11/12/16.
//  Copyright © 2016 kickenadz. All rights reserved.
//

import Foundation

struct Session {
    let urlSession: URLSession
    
    init() {
        let sessionConfig = URLSessionConfiguration.ephemeral
        sessionConfig.httpAdditionalHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "User-Agent": "kickenadz/\(kickenadzVersionNumber) (\(UIDevice.deviceModel); \(UIDevice.osVersion))"
        ]
        urlSession = URLSession(configuration: sessionConfig)
    }
}
