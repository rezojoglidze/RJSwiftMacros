//
//  DataProvider.swift
//
//
//  Created by Rezo Joglidze on 28.07.24.
//

import Foundation

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
    func price() -> Double
}


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
    
    func price() -> Double {
        [
            84.96,
            72.04,
            63.48,
            80.62,
            45.55,
            46.4,
            40.7,
            21.23,
            20.15,
            28.01,
            19.49,
            86.12,
            40.12,
            19.98,
            41.68,
            46.8,
            35.82,
            58.51,
            98.82,
            71.84,
            22.39,
            45.62,
            76.35,
            26.21,
            35.85,
            91.68,
            53.73,
            24.21,
            35.21,
            36.59,
            16.54,
            4.75,
            20.16,
            18.45,
            34.12,
            52.56,
            31.26,
            93.89,
            87.46,
            89.04,
            97.78,
            3.41,
            28.47,
            17.54,
            10.71,
            82.31,
            5.48,
            4.87,
            19.73,
            60.29,
            96.39,
            81.48,
            95.49,
            44.81,
            97.65,
            55.3,
            22.56,
            30.64,
            60.26,
            44.66,
            4.59,
            86.96,
            89.16,
            85.95,
            6.67,
            26.79,
            64.61,
            35.11,
            98.29,
            60.99,
            94.85,
            87.54,
            67.08,
            34.62,
            69.71,
            54.9,
            58.52,
            95.12,
            78.12,
            0.88,
            6.94,
            98.21,
            40.37,
            60.3,
            69.56,
            16.81,
            57.56,
            29.51,
            16.67,
            11.87,
            57.2,
            86.24,
            71.05,
            12.04,
            61.44,
            61.72,
            34.68,
            57.51,
            69.06,
            3.45,
        ].randomElement()!
    }
}
