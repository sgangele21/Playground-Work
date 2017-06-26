// iOS Interview Question given by Facebook
// Thought it was simple, yet shows your thinking sufficiently

// Goal:
// Given an array of numbers write a method that moves non-zero elements to the front of the array
// and returns the count of non-zero elements.

var nums: [Int] = [0,2,0,0,5,3,2,0,7,9,0]
let count = nums.count
var nonZeroCounter = 0
for i in 0..<count {
    if nums[i] != 0 {
        nums[nonZeroCounter] = nums[i]
        if i != nonZeroCounter {
            nums[i] = 0
        }
        nonZeroCounter += 1
    }
}
print("Count of non-zero elements: \(nonZeroCounter)")
print(nums)

// Runs in O(n) time
