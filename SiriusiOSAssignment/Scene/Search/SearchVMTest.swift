//
//  SearchVMTest.swift
//  SiriusiOSAssignmentTests
//
//  Created by Nay Oo Linn on 06/10/2022.
//

import XCTest
@testable import SiriusiOSAssignment

class SearchVMTest: XCTestCase {

    var sut: SearchVM!
    
    override func setUp() {
        sut = SearchVM()
        sut.dataModel.data = CityData.mocks()
    }
    
    // Sort data by name
    func testSortData() {
        let result = sut.sortDataByName(sut.dataModel.data)
        XCTAssertEqual(result[0].name, "A City", "Index 0 city name must be 'A City'")
        XCTAssertEqual(result[1].name, "B City", "Index 1 city name must be 'B City'")
        XCTAssertEqual(result[2].name, "C City", "Index 2 city name must be 'C City'")
        XCTAssertEqual(result[3].name, "a City", "Index 3 city name must be 'a City'")
        XCTAssertEqual(result[4].name, "b City", "Index 4 city name must be 'b City'")
        XCTAssertEqual(result[5].name, "c City", "Index 5 city name must be 'c City'")
    }
    
    // Sort data for filtering
    func testGroupData() {
        let _ = sut.sortDataForSearch(sut.dataModel.data)
        let result = sut.dataModel.sortedData
        
        XCTAssertEqual(result["a"]?.count, 2, "Dictionary key 'a' must has only 2 objects")
        XCTAssertTrue(
            result["a"]?.contains(where: { $0.name == "A City" ||  $0.name == "a City"}) ?? false,
            "Dictionary key 'a' must has 'A City' and 'a City'"
        )
        
        XCTAssertEqual(result["b"]?.count, 2, "Dictionary key 'b' must has only 2 objects")
        XCTAssertTrue(
            result["b"]?.contains(where: { $0.name == "B City" ||  $0.name == "b City"}) ?? false,
            "Dictionary key 'b' must has 'B City' and 'b City'"
        )
        
        XCTAssertEqual(result["c"]?.count, 2, "Dictionary key 'c' must has only 2 objects")
        XCTAssertTrue(
            result["c"]?.contains(where: { $0.name == "C City" ||  $0.name == "c City"}) ?? false,
            "Dictionary key 'c' must has 'C City' and 'c City'"
        )
    }
    
    // Search with empty text
    func testSearchWithEmptyText() {
        let result = sut.search("")
        XCTAssertEqual(result.count, CityData.mocks().count)
    }
    
    // Search case insensitive
    func testSearchCaseInsensitive() {
        let _ = sut.sortDataForSearch(sut.dataModel.data)
        
        let result1 = sut.search("a")
        let result2 = sut.search("A")
        
        XCTAssertEqual(result1.count, result2.count, "Result counts must be same")
        XCTAssertEqual(result1[0].name, result2[0].name, "Results -> index 0 names must be same")
        XCTAssertEqual(result1[1].name, result2[1].name, "Results -> index 1 names must be same")
    }
    
    // Search with spaces
    func testSearchWithSpace() {
        let _ = sut.sortDataForSearch(sut.dataModel.data)
        
        let result = sut.search("    c city   ")

        XCTAssertEqual(result.count, 2, "Result count must be 2")
        XCTAssertTrue(
            result.contains(where: { $0.name == "C City" ||  $0.name == "c City"}),
            "Result must contain 'C City' and 'c City'"
        )
    }
    
    // Search with invalid text
    func testSearchWithInvalidText() {
        let _ = sut.sortDataForSearch(sut.dataModel.data)
        
        let result = sut.search("d")
        
        XCTAssertEqual(result.count, 0, "No result should return")
    }
}
