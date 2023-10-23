import XCTest
@testable import iFixFloat

final class iFixFloatTests: XCTestCase {
    func testBasic() {
        let result = UInt128.multiply(2, 3)
        XCTAssertEqual(result.high, 0)
        XCTAssertEqual(result.low, 6)
    }
    
    func testOverflow() {
        let result = UInt128.multiply(0x1_0000_0000, 0x1_0000_0000)
        XCTAssertEqual(result.high, 1)
        XCTAssertEqual(result.low, 0)
    }
    
    func testMax() {
        let result = UInt128.multiply(0xFFFF_FFFF_FFFF_FFFF, 0xFFFF_FFFF_FFFF_FFFF)
        XCTAssertEqual(result.high, 0xFFFF_FFFF_FFFF_FFFE)
        XCTAssertEqual(result.low, 1)
    }

    func testZero() {
        let result = UInt128.multiply(0, 1234567890)
        XCTAssertEqual(result.high, 0)
        XCTAssertEqual(result.low, 0)
    }
    
    func testOne() {
        let result = UInt128.multiply(1, 1234567890)
        XCTAssertEqual(result.high, 0)
        XCTAssertEqual(result.low, 1234567890)
    }
    
    func test_0() {
        let result = UInt128.multiply(0xFFFF_0000_FFFF_FFFF, 0xFFFF_FFFF_0000_FFFF)
        XCTAssertEqual(result.high, 0xFFFF_0000_0001_FFFC)
        XCTAssertEqual(result.low, 0x1_FFFF_FFFF_0001)
    }
    
    func test_1() {
        let result = UInt128.multiply(0x825e0a1f447a9d0f, 0xbeae05eb50b368cd)
        XCTAssertEqual(result.high, 0x611a6a71c1b2333b)
        XCTAssertEqual(result.low, 0x967f7971277add03)
    }
    
    func test_2() {
        let result = UInt128.multiply(0xa40f0cc4738525b, 0xc4339113aff1fb8)
        XCTAssertEqual(result.high, 0x7dbc91bf17af89)
        XCTAssertEqual(result.low, 0x76583e40a9193668)
    }
    
    func test_3() {
        let result = UInt128.multiply(0x013d10e9cab6d9101, 0x0ac718b6798f0cc2b)
        XCTAssertEqual(result.high, 0xd593fe33e37ff5f)
        XCTAssertEqual(result.low, 0xc8adf423a3e4272b)
    }
    
    func test_4() {
        let result = UInt128.multiply(0xfb1d552bec078d70, 0xcf842b7995bb80d0)
        XCTAssertEqual(result.high, 0xcb8e5da39f8b7104)
        XCTAssertEqual(result.low, 0xcbf4a27a0daaeb00)
    }
    
    func test_5() {
        let result = UInt128.multiply(0x38f44d557e6d9bc0, 0xb5f343ebf6828e7f)
        XCTAssertEqual(result.high, 0x287ad9af49e2acce)
        XCTAssertEqual(result.low, 0x86a08a1e1c44c440)
    }
    
    func test_6() {
        let result = UInt128.multiply(0x5522e2b50ba73069, 0x13bdc5312abbf74)
        XCTAssertEqual(result.high, 0x690b32901dff58)
        XCTAssertEqual(result.low, 0xcab645dabd034694)
    }
    
    func test_7() {
        let result = UInt128.multiply(0xfa2d1b0f09047b2a, 0xb0d6f746db94b662)
        XCTAssertEqual(result.high, 0xacd115f5b8cb70b0)
        XCTAssertEqual(result.low, 0xf7144b9ac58f0214)
    }
    
    func test_8() {
        let result = UInt128.multiply(0x24346c19605512a6, 0x6ccd292ea2c6cb3)
        XCTAssertEqual(result.high, 0xf63216842b6cea)
        XCTAssertEqual(result.low, 0xaec56ab92fe21212)
    }
    
    func test_9() {
        let result = UInt128.multiply(0xe9ffe90c7f3adc66, 0xebc8a042d873cba1)
        XCTAssertEqual(result.high, 0xd7854d59960a17c4)
        XCTAssertEqual(result.low, 0xbc51dd72c29b7e26)
    }
    
    func test_10() {
        let result = UInt128.multiply(0x22e0c81bc93e3a9, 0xa036a6c01e0db3)
        XCTAssertEqual(result.high, 0x15d3ef338213a)
        XCTAssertEqual(result.low, 0x65039ef3cbc5c42b)
    }
}
