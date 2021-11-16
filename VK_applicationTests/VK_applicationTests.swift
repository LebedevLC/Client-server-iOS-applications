//
//  VK_applicationTests.swift
//  VK_applicationTests
//
//  Created by Сергей Чумовских  on 07.11.2021.
//

import XCTest
@testable import VK_application

class VKapplicationTests: XCTestCase {
    var sut: UserGroupsViewController!

    override func setUp() {
        super.setUp()
        sut = UserGroupsViewController()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testExample() throws {
    }
}
