# FixFloat

This fixed float math library provides an efficient and deterministic solution for arithmetic and geometric operations.

## Features

- Fixed-point arithmetic using FixNumber for deterministic calculations

- 2D fixed-point vector operations with FixVec

- Trigonometric functions using fixed-point angles

- Angle conversion and manipulation utilities in FixAngle


## Installation

Add iFixFloat using swift package manager:

- Open your Xcode project.
- Select your project and open tab Package Dependencies.
- Click on the "+" button.
- In search bar enter "https://github.com/iShape-Swift/iFixFloat".
- Click the "Add" button.
- Wait for the package to be imported.
- In your Swift code, add the following using statement to access the library:

```swift
import iFixFloat
```


## How It Works

The \`**FixFloat**\` extension uses fixed-point arithmetic to perform calculations with a high degree of precision and determinism. It supports numbers in the range 2^21 - 1 to -2^21 + 1 with a precision of 1/1024, and is most suitable for the range 1,000,000 to -1,000,000 with a precision of 0.01.

Fixed-point numbers are represented using a fixed number of bits for the fractional part. In this implementation, the number of bits representing the fractional part of the fixed-point number is 10, which allows for a precision of 1/1024 or approximately 0.001.

Here are some examples of fixed-point number representation:

- 1 / 1024 ≈ 0.001 (represented as 1)
- 256 / 1024 = 0.25 (represented as 256)
- 1024 / 1024 = 1 (represented as 1024)
- (1024 + 512) / 1024 = 1.5 (represented as 1536)
- (2048 + 256) / 1024 = 2.25 (represented as 2304)

By using the \`**FixFloat**\` extension, you can perform arithmetic operations using Int64 values while maintaining the precision of floating-point numbers, ensuring deterministic behavior across different platforms and devices.


## Usage

### FixFloat

The \`**FixFloat**\` extension represents a fixed-point number using a \`**Int64**\` as the underlying storage, allowing deterministic arithmetic operations. Use \`**FixFloat**\` for calculations instead of \`**Float**\` or \`**Double**\` when deterministic behavior is required. \`**FixFloat**\` provides a way to perform arithmetic operations with \`**Int64**\` values while maintaining the precision of floating-point numbers.

```swift
let a = 3.14.fix
let b = 2.0.fix
let result = a.mul(b)
let resultAsFloat = result.float
```

### FixVec

The \`**FixVec**\` struct represents a 2D fixed-point vector, providing various utility methods and operators for vector operations. Use \`**FixVec**\` for 2D geometric calculations when deterministic behavior is required.

```swift
let vec1 = FixVec(1.0.fix, 2.0.fix)
let vec2 = FixVec(3.0.fix, 4.0.fix)

let sum = vec1 + vec2
let difference = vec1 - vec2
```

### FixAngle
The \`**FixAngle**\` class provides various utility methods for working with fixed-point angles, including trigonometric functions and angle conversion.


```swift
let angle = (Double.pi / 2).fix.radToFixAngle
let sin = angle.sin
let cos = angle.cos
```


## License
