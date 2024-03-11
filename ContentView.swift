import SwiftUI
var simArray1 = [42, 32, 23, 12, 19, 54]
var bubbleSortRun = false

func bubbleSort(_ array: inout [Int]) {
    let size = array.count
    for x in 0..<size {
        for y in 0..<size-x-1 {
            // Compare two adjacent elements
            if array[y] > array[y+1] {
                // Swap the elements if they are
                // not in the correct order
                let temp = array[y]
                array[y] = array[y+1]
                array[y+1] = temp
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("harry's searching and sorting emporium")
                NavigationLink("Run Bubble Sort", destination: BubbleSortView())
                NavigationLink("Run Binary Search", destination: BinarySearchView(searchTerm: ""))
            } .navigationTitle("search and sort app 👍")
        }
    }
}

struct BubbleSortView: View {
    @State var sortedArray = simArray1
    
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    bubbleSort(&sortedArray)
                    if bubbleSortRun == false {
                        bubbleSortRun = true
                    }
                    print(sortedArray)
                    print(simArray1)
                    print(bubbleSortRun)
                }, label: {
                    Text("Sort")
                })
                
                Text("Array")
                    .font(.title)
                    .fontWeight(.bold)
                List(simArray1, id: \.self) { number in 
                    Text("\(number)")
                }
                Text("Sorted Array")
                    .font(.title)
                    .fontWeight(.bold)
                List(sortedArray, id: \.self) { number in 
                    Text("\(number)")
                }
            } .navigationTitle("Bubble Sort")
        }
    }
}

struct BinarySearchView: View {
    
@State var searchTerm: String
func binarySearch<T: Comparable>(in array: [T], for value: T) -> Int? {
        var lowerBound = 0
        var upperBound = array.count - 1
        
        while lowerBound <= upperBound {
            let middleIndex = (lowerBound + upperBound) / 2
            if array[middleIndex] == value {
                return middleIndex
            } else if array[middleIndex] < value {
                lowerBound = middleIndex + 1
            } else {
                upperBound = middleIndex - 1
            }
        }
        return nil
    }
    var body: some View {
        NavigationStack {
            VStack {
                if bubbleSortRun == false {
                    Text("You must run a Bubble Sort before using the Binary Search.")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                } else {
                    TextField("Search", text: $searchTerm)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .keyboardType(.numberPad)
                    
                    Button(action: {
                        let sorted: () = bubbleSort(&simArray1)
                        print(sorted)
                        binarySearch(in: [sorted], for: $searchTerm)
                    }, label: {
                        Text("Run Search")
                    })
                }
            } .navigationTitle("Binary Search")
        }
    }
}
