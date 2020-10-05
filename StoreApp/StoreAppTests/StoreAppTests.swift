//
//  StoreAppTests.swift
//  StoreAppTests
//
//  Created by 채훈기 on 2020/09/28.
//

import XCTest
@testable import StoreApp

class StoreAppTests: XCTestCase {

    
    let validator = Validator()

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_id_verify_available() throws {
        XCTAssertEqual(ValidatorMessage.validId, validator.id(input: "chaehk95"))
    }

    func test_id_verify_fail_less_length() throws {
        XCTAssertEqual(ValidatorMessage.invalidlengthID, validator.id(input: "chae"))
    }
    
    func test_id_verify_fail_Include_special_character() throws {
        XCTAssertEqual(ValidatorMessage.invalidSpecialCharactor, validator.id(input: "chaeee&^%$"))
    }

    func test_id_verify_success_Include_underbar() throws {
        XCTAssertEqual(ValidatorMessage.validId, validator.id(input: "chaeee_"))
    }
    
    func test_id_verify_success_Include_dash() throws {
        XCTAssertEqual(ValidatorMessage.validId, validator.id(input: "chaeee-"))
    }
    
    func test_id_verify_success_Include_number() throws {
        XCTAssertEqual(ValidatorMessage.validId, validator.id(input: "chaeee932123"))
    }
    
    func test_password_verify_success_length() throws {
        XCTAssertEqual(ValidatorMessage.validPassword, validator.password(input: "adfSD2000!"))
    }
    
    func test_password_verify_fail_notInclude_number() throws {
        XCTAssertEqual(ValidatorMessage.invalidNotIncludeNumber, validator.password(input: "adfSDfdsd!"))
    }
    
    func test_password_verify_fail_notInclude_small() throws {
        XCTAssertEqual(ValidatorMessage.invalidNotIncludeSmall, validator.password(input: "ADSFAS12!"))
    }
    
    func test_password_verify_fail_notInclude_large() throws {
        XCTAssertEqual(ValidatorMessage.invalidNotIncludeLarge, validator.password(input: "asdffes12!"))
    }
    
    func test_password_verify_fail_notInclude_special() throws {
        XCTAssertEqual(ValidatorMessage.invalidNotIncludeSpecial, validator.password(input: "asdffesFD12"))
    }
    
    func test_password_verify_fail_notInclude_space() throws {
        XCTAssertEqual(ValidatorMessage.invalidIncludeSpace, validator.password(input: "asdf fesFD12"))
    }
    
    func test_password_verify_fail_notInclude_space1() throws {
        XCTAssertEqual(ValidatorMessage.invalidIncludeSpace, validator.password(input: "asdffesFD12 "))
    }
    func test_password_verify_fail_notInclude_space2() throws {
        XCTAssertEqual(ValidatorMessage.invalidIncludeSpace, validator.password(input: " asdffesFD12"))
    }
}

