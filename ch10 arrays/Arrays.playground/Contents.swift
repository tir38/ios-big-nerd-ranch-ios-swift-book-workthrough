//: Playground - noun: a place where people can play

import Cocoa

var bucketList = ["climb Mt. Everest"]
bucketList.append("visit Fiji")
bucketList.append("snorkel in the Indian Ocean")
bucketList.append("camp in Yellowstone")
bucketList.append("ride bikes in Belgium")

bucketList.removeAtIndex(2)
bucketList.count
bucketList[0...2]

// update items in array without pulling item out and putting back
bucketList[2] += " and see some bears"

// replace items in array
bucketList[0] = "lie about climbing Mt. Everest"

// join two arrays
var otherItems = ["race motorcycles", "own a fainting pygmy goat"]

bucketList.extend(otherItems)

// another way to join two arrays
bucketList += otherItems // like em so much I want to do them twice

// insert
bucketList.insert("cross country ski", atIndex: 3)

println(bucketList)


// bronze challenge
println("\n\n")

var toDoList = ["Take out garbage", "Pay bills", "Cross off finished items"]

println("to do list is empty: \(toDoList.isEmpty)")


// silver challenge
println("\n\n")

var reversedList = toDoList.reverse()
println(reversedList)