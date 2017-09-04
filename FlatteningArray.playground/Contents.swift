/*
Flatten Array Interview Question
 
General Idea:
We first need to realize that we have to iterate through every single element
So I think the most efficient way we can do this is O(n) time

We have to solve this recursively
 
Base Case: Well, when iterating through something, you must know the length, because that is 
    what determines the stopping point of an array. So, when iterating you keep a currentIndex, and when that reaches the
    count of the current array, you know to stop
 
Iterating through array: We have a currentIndex, so whenever we want to iterate we add the current element to the new array and we increment the currentIndex
 
Removing any nested arrays: We have to do this recursively, so when you see there is an array as the current element, simply iterate through it recursively passing in the currentIndex 0, and passing in the nested array, and of course the newArray
 
Creating new array: We have to keep a variable that always stays in the function, so that we can add the current element to it, flatly. That is why we have a newArray parameter

When to acutally return the newArray: Do it when the currentIndex is equal to the count of the current array. This makes sense recursively.

 */

func flattenArray(array: [Any], newArray: [Any] = [], currentIndex: Int = 0) -> [Any] {
    var newArray = newArray
    // Base case
    if array.count == currentIndex {
        // This is where the array will be returned
        return newArray
    }
    // Case for nested arrays
    if let nestedArray = array[currentIndex] as? [Any] {
        // After you nest through an array fully, there could be more elements after it.... eg. the 16
        // So continue iterating through the array with the updated newArray
        newArray = flattenArray(array: nestedArray, newArray: newArray)
    }
    // Case for simply iterating through array and adding it to newArray if the current element is not a nested array
    if let currentElement = array[currentIndex] as? Int {
        newArray.append(currentElement)
        return flattenArray(array: array, newArray: newArray, currentIndex: currentIndex + 1)
    }
    
    // This is here to simply iterate through the array
    return flattenArray(array: array, newArray: newArray, currentIndex: currentIndex + 1)
}

let array: [Any] = [1,2,3,4,[5,6,7,[8,9, [10,11,12,13,14,15]]], 16]

let flattenedArray = flattenArray(array: array)
print(flattenedArray)