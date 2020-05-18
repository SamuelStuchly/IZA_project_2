import XCTest

import sudokuTests

var tests = [XCTestCaseEntry]()
tests += sudokuTests.allTests()
XCTMain(tests)
