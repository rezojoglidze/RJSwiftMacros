//
//  DataProvider.swift
//
//
//  Created by Rezo Joglidze on 28.07.24.
//

import Foundation

// MARK: - Protocols For Fake Data
protocol StringDataProvider {
    func randomString() -> String
}

protocol BooleanDataProvider {
    func randomBool() -> Bool
}

protocol DateDataProvider {
    func date() -> Date
}

protocol URLDataProvider {
    func url() -> URL
}

protocol NumericDataProvider {
    func randomInt(min: Int, max: Int) -> Int
    func randomFloat(min: Float, max: Float) -> Float
    func randomDouble(min: Double, max: Double) -> Double
}


// MARK: - Fake Data Provider
struct FakeDataProvider: StringDataProvider {
    func randomString() -> String {
        return [
            "Jeanie",
            "Roselyn",
            "Giles",
            "Montana",
            "Maximillia",
            "Etha",
            "Tony",
            "Lila",
            "Malcolm",
            "Clare",
            "Sonny",
            "Jensen",
            "Erik",
            "Alvera",
            "Alysson",
            "Queenie",
            "Kadin",
            "Nyasia",
            "Christina",
            "Otis",
            "Brook",
            "Demetrius",
            "Janiya",
            "Cloyd",
            "Estell",
            "Rafaela",
            "Wilfrid",
            "Fletcher",
            "Justus",
            "Gilda",
            "Orion",
            "Johnnie",
            "Burnice",
            "Mandy",
            "Precious",
            "Margarette",
            "Nadia",
            "Emanuel",
            "Alysha",
            "Abigale",
            "Ariane",
            "Alec",
            "Declan",
            "Celestine",
            "Shaniya",
            "Amanda",
            "Rebeka",
            "Milo",
            "Bettye",
            "Marlene",
            "Alisa",
            "Sylvia",
            "Xavier",
            "Shanelle",
            "Lorna",
            "Felicia",
            "Deven",
            "Jayda",
            "Jesse",
            "Karolann",
            "Devin",
            "Cayla",
            "Nyah",
            "Eve",
            "Vicente",
            "Lauryn",
            "Lauren",
            "Pinkie",
            "Augustus",
            "Valentina",
            "Eladio",
            "Sabryna",
            "Jessie",
            "Emilia",
            "Gus",
            "Marc",
            "Bernardo",
            "Gavin",
            "Odie",
            "Gage",
            "Hertha",
            "Kristopher",
            "Darien",
            "Mya",
            "Domenica",
            "Enola",
            "Antonetta",
            "Michele",
            "Elian",
            "Lizzie",
            "Grace",
            "Jaren",
            "Gust",
            "Lonzo",
            "Buford",
            "Mitchell",
            "Enid",
            "Courtney",
            "Sherman",
            "Pitt"
        ].randomElement()!
    }
}

extension FakeDataProvider: BooleanDataProvider {
    func randomBool() -> Bool {
        Bool.random()
    }
}

extension FakeDataProvider: DateDataProvider {
    func date() -> Date {
        let years = 5
        let daysInYears = 365.25 // Consider average year including leap years
        let secondsInADay = 24.0 * 60.0 * 60.0
        
        // Current date as the start date
        let startDate = Date()
        
        // Maximum number of seconds in the specified number of years
        let maxSeconds = Int(daysInYears * Double(years) * secondsInADay)
        
        // Generate a random interval
        let randomInterval = TimeInterval(Int.random(in: 0..<maxSeconds))
        
        // Generate the random date
        return startDate.addingTimeInterval(randomInterval)
    }
}

extension FakeDataProvider: URLDataProvider {
    func url() -> URL {
        [
            URL(string: "https://www.google.com")!,
            URL(string: "https://www.youtube.com")!,
            URL(string: "https://www.facebook.com")!,
            URL(string: "https://www.wikipedia.org")!,
            URL(string: "https://www.amazon.com")!,
            URL(string: "https://www.twitter.com")!,
            URL(string: "https://www.instagram.com")!,
            URL(string: "https://www.linkedin.com")!,
            URL(string: "https://www.netflix.com")!,
            URL(string: "https://www.microsoft.com")!,
            URL(string: "https://www.apple.com")!,
            URL(string: "https://www.whatsapp.com")!,
            URL(string: "https://www.tiktok.com")!,
            URL(string: "https://www.ebay.com")!,
            URL(string: "https://www.reddit.com")!,
            URL(string: "https://www.spotify.com")!,
            URL(string: "https://www.airbnb.com")!,
            URL(string: "https://www.zoom.us")!,
            URL(string: "https://www.adobe.com")!,
            URL(string: "https://www.paypal.com")!,
        ].randomElement()!
    }
}

extension FakeDataProvider: NumericDataProvider {
    func randomInt(min: Int, max: Int) -> Int {
        Int.random(in: min...max)
    }
    
    func randomFloat(min: Float, max: Float) -> Float {
        Float.random(in: min...max)
    }
    
    func randomDouble(min: Double, max: Double) -> Double {
        Double.random(in: min...max)
    }
}
