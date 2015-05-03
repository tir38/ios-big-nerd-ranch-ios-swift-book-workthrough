//: Playground - noun: a place where people can play

import Cocoa

var movieRatings = ["Donnie Darko": 4,
    "Chungking Express": 5,
    "Dark City": 4]

println("I have rated \(movieRatings.count) movies.")

// i can pull value from dictionary
let darkoRating = movieRatings["Donnie Darko"]
println(darkoRating)

// i can update dictionary
movieRatings["Dark City"] = 5
println(movieRatings)

// i can use updateValue() method too!
let oldRating: Int? = movieRatings.updateValue(5, forKey: "Donnie Darko")
if let lastRating = oldRating {
    println(lastRating)
}

// i can also use shadowing
if let oldRating = oldRating {
    println(oldRating)
}

// add entry if it doesnt' exist
movieRatings["The Cabinet of Dr. Caligari"] = 5

// remove entry
let removeRating: Int? = movieRatings.removeValueForKey("Donnie Darko")
println(removeRating)

// loop over dictionary
for (title, rating) in movieRatings {
    println("The movie \(title) was rated \(rating) stars.")
}

// can also use for in loop
for movie in movieRatings.keys { // the cool thing here is  that keys are of the non-optional type, because they are guaranteed to have a value!    println("User has rated \(movie)")
}

// i can create an array from a dictionary
let watchedMovies = Array(movieRatings.keys)

let ratings = Array(movieRatings.values)


// ------ challenge
println("\n\nCHALLENGE:\n")
// setup
var georgia: [String: [Int]] = [:]
var fultonCountyZips =  [30312, 30313, 30307, 30303]
var dekalbCountyZips =  [30317, 30030, 30032]
var gwinnettCountyZips = [30047, 30044, 30071]

georgia["fulton"] = fultonCountyZips
georgia["dekalb"] = dekalbCountyZips
georgia["gwinnett"] = gwinnettCountyZips

println("Georgia has \(georgia.count) counties.\n\n")

// print num counties and list of zips
var totalZipCount: Int = 0
var zipsString: String = "Georgia has zipcodes : ["

for county in georgia.keys {
    if let singleCountyZipCount = georgia[county]?.count {
        totalZipCount += singleCountyZipCount
    }
    
    var zips = georgia[county]
    if let zips = zips { // unwrap
        for zip in zips {
            zipsString += "\(zip),"
        }
    }
}
zipsString += "]"

println("Total number of zip codes: \(totalZipCount)\n\n")

println(zipsString)