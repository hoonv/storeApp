//
//  StoreAppTests.swift
//  StoreAppTests
//
//  Created by 채훈기 on 2020/09/28.
//

import XCTest
@testable import StoreApp

class StoreAppTests: XCTestCase {

    let idValidator = IdValidator()
    let pwValidator = PwValidator()
    let nameValidator = NameValidator()

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_id_verify_success() throws {
        XCTAssertEqual(ValidatorMessage.validId, idValidator.validate(input: "chaehk95"))
    }

    func test_id_verify_fail_less_length() throws {
        XCTAssertEqual(ValidatorMessage.invalidlengthID, idValidator.validate(input: "chae"))
    }
    
    func test_id_verify_fail_Include_special_character() throws {
        XCTAssertEqual(ValidatorMessage.invalidSpecialCharactor, idValidator.validate(input: "chaeee&^%$"))
    }

    func test_id_verify_success_Include_underbar() throws {
        XCTAssertEqual(ValidatorMessage.validId, idValidator.validate(input: "chaeee_"))
    }
    
    func test_id_verify_success_Include_dash() throws {
        XCTAssertEqual(ValidatorMessage.validId, idValidator.validate(input: "chaeee-"))
    }
    
    func test_id_verify_success_Include_number() throws {
        XCTAssertEqual(ValidatorMessage.validId, idValidator.validate(input: "chaeee932123"))
    }
    
    func test_password_verify_success_length() throws {
        XCTAssertEqual(ValidatorMessage.validPassword, pwValidator.validate(input: "adfSD2000!"))
    }
    
    func test_password_verify_fail_notInclude_number() throws {
        XCTAssertEqual(ValidatorMessage.invalidNotIncludeNumber, pwValidator.validate(input: "adfSDfdsd!"))
    }
    
    func test_password_verify_fail_notInclude_small() throws {
        XCTAssertEqual(ValidatorMessage.invalidNotIncludeSmall, pwValidator.validate(input: "ADSFAS12!"))
    }
    
    func test_password_verify_fail_notInclude_large() throws {
        XCTAssertEqual(ValidatorMessage.invalidNotIncludeLarge, pwValidator.validate(input: "asdffes12!"))
    }
    
    func test_password_verify_fail_notInclude_special() throws {
        XCTAssertEqual(ValidatorMessage.invalidNotIncludeSpecial, pwValidator.validate(input: "asdffesFD12"))
    }
    
    func test_password_verify_fail_notInclude_space() throws {
        XCTAssertEqual(ValidatorMessage.invalidIncludeSpace, pwValidator.validate(input: "asdf fesFD12"))
    }
    
    func test_password_verify_fail_notInclude_space1() throws {
        XCTAssertEqual(ValidatorMessage.invalidIncludeSpace, pwValidator.validate(input: "asdffesFD12 "))
    }
    func test_password_verify_fail_notInclude_space2() throws {
        XCTAssertEqual(ValidatorMessage.invalidIncludeSpace, pwValidator.validate(input: " asdffesFD12"))
    }
    
    func test_id_verify_fail_empty() throws {
        XCTAssertEqual(ValidatorMessage.emptyId, idValidator.validate(input: ""))
    }
    
    func test_password_verify_fail_empty() throws {
        XCTAssertEqual(ValidatorMessage.emptyPassword, pwValidator.validate(input: ""))
    }
    
    func test_name_verify_fail_empty() throws {
        XCTAssertEqual(ValidatorMessage.emptyName, nameValidator.validate(input: ""))
    }
    
    func test_name_verify_fail_special() throws {
        XCTAssertEqual(ValidatorMessage.invaildNameSpecial, nameValidator.validate(input: "훈기^"))
    }
    
    func test_name_verify_fail_number() throws {
        XCTAssertEqual(ValidatorMessage.invaildNameNumber, nameValidator.validate(input: "훈기6"))
    }
}

