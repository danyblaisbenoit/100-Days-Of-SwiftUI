import Cocoa

// create a string array
let videoGames = ["Black Myth Wukong", "Astro Bot", "Silent Hill 2", "Helldivers 2", "Astro Bot"]

// print the number of element in the array
print("The video game array has \(videoGames.count) elements")

// print the number of unique elements in the array
let uniqueVideoGames = Set(videoGames)
print("The unique video game array has \(uniqueVideoGames.count) elements")
