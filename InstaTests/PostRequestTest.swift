//
//  PostRequestTest.swift
//  InstaTests
//
//  Created by YuanChingChen on 2023/7/15.
//

import XCTest
@testable import Insta

final class PostRequestTest: XCTestCase {
    func testHandleWithGoodData() throws {
      let data = JsonData.validFeed.data(using: .utf8)!

      let request = PostRequest()
      do {
        let result = try request.handle(response: data)
        XCTAssertEqual(result.count, 3)
      } catch let decodingError as DecodingError {
        XCTFail((decodingError as CustomDebugStringConvertible).debugDescription)
      } catch let error {
        XCTFail(error.localizedDescription)
      }
    }
    
    func testHandleWithBadData() {
      let data = JsonData.inValidJson.data(using: .utf8)!

      let request = PostRequest()
      XCTAssertThrowsError(try request.handle(response: data)) { error in
        XCTAssertTrue(error is DecodingError)
      }
    }

}
