//
//  Placement+Records.swift
//  kickenadz
//
//  Created by Ryuichi Saito on 11/20/16.
//  Copyright © 2016 kickenadz. All rights reserved.
//

import Foundation

public extension Placement {
    /// Sends request to record impression for this `Placement`.
    func recordImpression() {
        if let accupixelUrl = self.accupixelUrl.flatMap({ URL(string: $0) }) {
            kickenadz.requestPixel(with: accupixelUrl)
        }
        if let trackingPixel = self.trackingPixel.flatMap({ URL(string: $0) }) {
            kickenadz.requestPixel(with: trackingPixel)
        }
    }
    
    /// Sends request to record click for this `Placement`.
    func recordClick() {
        if let redirectUrl = self.redirectUrl.flatMap({ URL(string: $0) }) {
            kickenadz.requestPixel(with: redirectUrl)
        } else {
            print("Cannot construct a valid redirect URL.")
        }
    }
}
