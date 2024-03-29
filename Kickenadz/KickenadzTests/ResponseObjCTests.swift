//
//  ResponseObjCTests.swift
//  kickenadz
//
//  Created by Ryuichi Saito on 12/19/16.
//  Copyright © 2016 kickenadz. All rights reserved.
//

import XCTest

@testable import kickenadz

class ResponseObjCTests: XCTestCase {
    
    func testSuccessCallback() {
        let expct = expectation(description: "expect to get a callback")
        let resp = Response.success(.noAds, [])
        resp.objcCallbacks(success: { _,_  in
            expct.fulfill()
        }, failure: { _,_,_  in
            XCTFail()
        })
        waitForExpectations(timeout: 3)
    }
    
    func testBadRequest() {
        let expct = expectation(description: "expect to get a callback")
        let resp = Response.badRequest(0, "")
        resp.objcCallbacks(success: { _,_  in
            XCTFail()
        }, failure: { _,_,_  in
            expct.fulfill()
        })
        waitForExpectations(timeout: 3)
    }
    
    func testInvalidJSON() {
        let expct = expectation(description: "expect to get a callback")
        let resp = Response.invalidJson("")
        resp.objcCallbacks(success: { _,_  in
            XCTFail()
        }, failure: { _,_,_  in
            expct.fulfill()
        })
        waitForExpectations(timeout: 3)
    }
    
    func testRequestError() {
        let expct = expectation(description: "expect to get a callback")
        let resp = Response.requestError(TestError())
        resp.objcCallbacks(success: { _,_  in
            XCTFail()
        }, failure: { _,_,_  in
            expct.fulfill()
        })
        waitForExpectations(timeout: 3)
    }
}
