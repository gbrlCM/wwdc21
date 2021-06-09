//
//  AwaitTests.swift
//  AwaitTests
//
//  Created by Gabriel Ferreira de Carvalho on 08/06/21.
//

import XCTest
@testable import Await

class AwaitTests: XCTestCase {

    var sut: GitDataService!
    
    override func setUp() {
        super.setUp()
        sut = GitDataService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testAsync() async {
        await sut.toogleBool()
        XCTAssertTrue(sut.someBool)
    }
    
    func testCompletion() {        
        let expectation = XCTestExpectation()
        
        sut.toogleWithCompletion { res in
            if case .success(let bool) = res {
                XCTAssertTrue(bool)
                expectation.fulfill()
            }
        }
        
        
       wait(for: [expectation], timeout: 6)
    }
}
