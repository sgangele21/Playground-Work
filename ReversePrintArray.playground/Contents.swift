// Super Slight Interview Question

// Take an array, and reverse it
// Printing out each element with a space in-between it
// -----------------------------------------------------
let array: [Int] = [1,2,3,4,5,6,7,8,9]

// Verbose Method
let lastIndex = array.count - 1
var str = ""
for i in 0..<array.count {
    let currIndex = lastIndex - i
    let value = array[currIndex]
    str += "\(value) "
}
print(str)

// Sexy One Liner
array.reversed().map { (num) in print("\(num) ", terminator:"") }
// The terminator stops the print function
// from defaulting to print a new line