import Cocoa

// 1. Create a constant holding any temperature in Celsius.
let temperatureInCelsius = 25.0

// 2. Converts it to Fahrenheit by multiplying by 9, dividing by 5, then adding 32.
let temperatureInFahrenheit = temperatureInCelsius * 9.0 / 5.0 + 32.0

// 3. Prints the result for the user, showing both the Celcius and Fahrenheit.
print("\(temperatureInCelsius)°C is \(temperatureInFahrenheit)°F")
