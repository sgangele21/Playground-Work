// Suppper Slight intereview question:
// Find the minimum element in an array, in a recursive manner
// Solution assumes the array is not empty
let array = [1,2,3,1,6,90,-2,6,-90]

// Iterative Solution
// Uses a dict to keep track of the minimum element
var dict: [String: Int] = [:]
let key = "MinNum"
dict[key] = array.first
// Iterates throught array, checking if the number in the arra
// Is less than the current number in dict, if so, update the number in the dict
for num in array {
    if num < dict[key]!  {
        dict[key] = num
    }
}
print(dict[key]!)


// I simply transformed everything from the iterative solution
// Into a recursive solution


// Recursive Solution
// Here is a helper method, that is easier to call initially
func findMin(array: [Int]) {
    findMin(array: array, currentIndex: 0, smallestValue: array.first!)
}
// Main method that performs recursion
func findMin(array: [Int], currentIndex: Int, smallestValue: Int) {
    // If we reach the end of the list.... which we have to...
    // We are done, return
    if currentIndex == array.count {
        print(smallestValue)
        return
    }
    // If the current smallest value is SMALLER than the current element in array
    // Then update the smallest value, and continue iterating
    // If the current smallest value is LARGER than the current element in array
    // Don't update, and continue iterating
    let updatedSmallestValue = array[currentIndex] < smallestValue ? array[currentIndex] : smallestValue
    findMin(array: array, currentIndex: currentIndex + 1, smallestValue: updatedSmallestValue)
}


findMin(array: array)
