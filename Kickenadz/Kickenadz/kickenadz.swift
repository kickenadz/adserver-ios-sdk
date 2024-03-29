//
//  kickenadz.swift
//  kickenadz
//
//  Created by Ryuichi Saito on 11/8/16.
//  Copyright © 2016 kickenadz. All rights reserved.
//

import Foundation

fileprivate let baseUrl = "https://servedbykickenadz.com/adserve"

/// The class used to make requests against the kickenadz API.
@objc public class kickenadz: NSObject {
    public override init() {
        super.init()
    }
    
    static var session = Session().urlSession
    
    /**
     Requests multiple placements.
     
     - Parameter with: the configurations, each used for one placement respectively.
     - Parameter completionHandler: a callback block that you provide to handle the response. The block will be given a `Response` object.
     */
    public static func requestPlacements(with configs: [PlacementRequestConfig], completionHandler: @escaping (Response) -> Void) {
        let requestManager = RequestManager(session: session, baseUrl: baseUrl, configs: configs, completionHandler: completionHandler)
        requestManager.request()
    }
    
    /**
     Requests multiple placements with explicit success and failure callbacks. Provided for Objective-C compatibility.
     
     - Parameter configs: the configurations, each used for one placement respectively.
     - Parameter success: a success callback block. The block will be given a `String` status and a list of `Placement`s.
     - Parameter failure: a failure callback block with status code, response body, and error.
     */
    @objc public static func requestPlacements(configs: [PlacementRequestConfig], success: @escaping (String, [Placement]) -> Void, failure: @escaping (NSNumber?, String?, Error?) -> Void) {
        requestPlacements(with: configs) { $0.objcCallbacks(success: success, failure: failure) }
    }
    
    /**
     Requests a single placement.
     
     - Parameter with: the configuration used for requesting one placement.
     - Parameter completionHandler: a callback block that you provide to handle the response. The block will be given a `Response` object.
     */
    public static func requestPlacement(with config: PlacementRequestConfig, completionHandler: @escaping (Response) -> Void) {
        let requestManager = RequestManager(session: session, baseUrl: baseUrl, config: config, completionHandler: completionHandler)
        requestManager.request()
    }
    
    
    /**
     Requests a single placement with explicit success and failure callbacks. Provided for Objective-C compatibility.
     
     - Parameter config: the configuration used for requesting one placement.
     - Parameter success: a success callback block. The block will be given a `String` status and a list of `Placement`s.
     - Parameter failure: a failure callback block with status code, response body, and error.
     */
    @objc public static func requestPlacement(config: PlacementRequestConfig, success: @escaping (String, [Placement]) -> Void, failure: @escaping (NSNumber?, String?, Error?) -> Void) {
        requestPlacement(with: config) { $0.objcCallbacks(success: success, failure: failure) }
    }
    
    /**
     Requests a pixel.
     
     - Parameter with: the `URL` for this pixel.
     */
    @objc(requestPixelWithURL:)
    public static func requestPixel(with url: URL) {
        let task = session.dataTask(with: url) { (_, _, error) in
            if error != nil {
                print("Error requeseting a pixel with url \(url.absoluteString)")
            }
        }
        task.resume()
    }
}

extension Response {
    func objcCallbacks(success: @escaping (String, [Placement]) -> Void, failure: @escaping (NSNumber?, String?, Error?) -> Void) {
        switch self {
        case .success(let status, let placements):
            success(status.rawValue, placements)
        case .badRequest(let statusCode, let responseBody):
            var statusCodeNumber: NSNumber? = nil
            if let statusCode = statusCode {
                statusCodeNumber = statusCode as NSNumber
            }
            failure(statusCodeNumber, responseBody, nil)
        case .invalidJson(let responseBody):
            failure(nil, responseBody, nil)
        case .requestError(let error):
            failure(nil, nil, error)
        }
    }
}
