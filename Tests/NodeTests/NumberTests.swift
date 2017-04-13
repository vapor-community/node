//
//  NumberTests.swift
//  Node
//
//  Created by Logan Wright on 7/20/16.
//
//

import XCTest
@testable import Node

class NumberTests: XCTestCase {
    static let allTests = [
        ("testSignedInit", testSignedInit),
        ("testUnsignedInit", testUnsignedInit),
        ("testFloatingPoint", testFloatingPoint),
        ("testAccessors", testAccessors),
        ("testBoolAccessors", testBoolAccessors),
        ("testIntMax", testIntMax),
        ("testDescriptions", testDescriptions),
        ("testEquatableTrue", testEquatableTrue),
        ("testEquatableFalse", testEquatableFalse),
    ]

    func testSignedInit() {
        let a = Node.Number(Int8(1))
        let b = Node.Number(Int16(-2))
        let c = Node.Number(Int32(3))
        let d = Node.Number(Int(-4))

        XCTAssert([a, b, c, d] == [1, -2, 3, -4])
    }

    func testUnsignedInit() {
        let a = Node.Number(UInt8(1))
        let b = Node.Number(UInt16(2))
        let c = Node.Number(UInt32(3))
        let d = Node.Number(UInt(4))

        XCTAssert([a, b, c, d] == [1, 2, 3, 4])
    }

    func testFloatingPoint() {
        let double = Double(52.899)
        let float = Float(10.5)
        let decimal = Decimal(5.25)

        XCTAssert(Node.Number(double) == 52.899)
        XCTAssert(Node.Number(float) == 10.5)
        XCTAssert(Node.Number(decimal) == 5.25)
    }

    func testAccessors() {
        let intRaw = Int(-42)
        let doubleRaw = Double(52.8)
        let uintRaw = UInt(3000)
        let decimalRaw = Decimal(43.12)

        let int = Node.Number(intRaw)
        XCTAssert(int.int == -42)
        XCTAssert(int.double == -42.0)
        XCTAssert(int.uint == 0)
        XCTAssert(int.decimal == -42.0)

        let double = Node.Number(doubleRaw)
        XCTAssert(double.int == 52)
        XCTAssert(double.double == 52.8)
        XCTAssert(double.uint == 52)
        XCTAssert(double.decimal == 52.8)

        let uint = Node.Number(uintRaw)
        XCTAssert(uint.int == 3000)
        XCTAssert(uint.double == 3000.0)
        XCTAssert(uint.uint == 3000)
        XCTAssert(uint.decimal == 3000.0)
        
        let decimal = Node.Number(decimalRaw)
        XCTAssert(decimal.int == 43)
        XCTAssert(decimal.double == 43.12)
        XCTAssert(decimal.uint == 43)
        XCTAssert(decimal.decimal == 43.12)
    }

    func testBoolAccessors() {
        let intTrue = Int(1)
        let doubleTrue = Double(1.0)
        let uintTrue = UInt(1)
        let decimalTrue = Decimal(1.0)
        XCTAssert(Node.Number(intTrue).bool == true)
        XCTAssert(Node.Number(doubleTrue).bool == true)
        XCTAssert(Node.Number(uintTrue).bool == true)
        XCTAssert(Node.Number(decimalTrue).bool == true)

        let intFalse = Int(0)
        let doubleFalse = Double(0.0)
        let uintFalse = UInt(0)
        let decimalFalse = Decimal(0.0)
        XCTAssert(Node.Number(intFalse).bool == false)
        XCTAssert(Node.Number(doubleFalse).bool == false)
        XCTAssert(Node.Number(uintFalse).bool == false)
        XCTAssert(Node.Number(decimalFalse).bool == false)

        let intNil = Int(-6)
        let doubleNil = Double(9.98)
        let uintNil = UInt(899999)
        let decimalNil = Decimal(12.34)
        XCTAssertNil(Node.Number(intNil).bool)
        XCTAssertNil(Node.Number(doubleNil).bool)
        XCTAssertNil(Node.Number(uintNil).bool)
        XCTAssertNil(Node.Number(decimalNil).bool)
    }

    func testIntMax() {
        let exceed = UInt.intMax + 50
        let number = Node.Number(exceed)
        XCTAssert(number.int == Int.max)
        XCTAssert(number.uint == exceed)
    }

    func testDescriptions() {
        let int = Int(-6)
        let double = Double(9.98)
        let uint = UInt(899999)
        let decimal = Decimal(3.21)

        XCTAssert(Node.Number(int).description == "-6")
        XCTAssert(Node.Number(double).description == "9.98")
        XCTAssert(Node.Number(uint).description == "899999")
        XCTAssert(Node.Number(decimal).description == "3.21")
    }

    func testEquatableTrue() {
        let int = Node.Number(Int(88))
        let double = Node.Number(Double(88))
        let uint = Node.Number(UInt(88))
        let decimal = Node.Number(Decimal(88))

        XCTAssert(int == int)
        XCTAssert(int == double)
        XCTAssert(int == uint)
        XCTAssert(int == decimal)

        XCTAssert(double == int)
        XCTAssert(double == double)
        XCTAssert(double == uint)
        XCTAssert(double == decimal)

        XCTAssert(uint == int)
        XCTAssert(uint == double)
        XCTAssert(uint == uint)
        XCTAssert(uint == decimal)
        
        XCTAssert(decimal == int)
        XCTAssert(decimal == double)
        XCTAssert(decimal == uint)
        XCTAssert(decimal == decimal)
    }

    func testEquatableFalse() {
        let int = Node.Number(Int(-1))
        let double = Node.Number(Double(99.8))
        let uint = Node.Number(UInt(9632))
        let decimal = Node.Number(Decimal(99))

        XCTAssert(int != double)
        XCTAssert(int != uint)
        XCTAssert(int != decimal)

        XCTAssert(double != int)
        XCTAssert(double != uint)
        XCTAssert(double != decimal)

        XCTAssert(uint != int)
        XCTAssert(uint != double)
        XCTAssert(uint != decimal)
    }

}
