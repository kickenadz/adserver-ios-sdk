//
//  ResponseCollector.swift
//  kickenadz
//
//  Created by Ryuichi Saito on 11/11/16.
//  Copyright © 2016 kickenadz. All rights reserved.
//

import Foundation

protocol ResponseCollector {
    var responses: [Response] { get }
    var complete: (Response) -> Void { get }
}
