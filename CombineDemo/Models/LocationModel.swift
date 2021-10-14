//
//  LocationModel.swift
//  CombineDemo
//
//  Created by Anjali Aggarwal on 06/10/21.
//

import Foundation

// MARK: - Welcome
struct Location: Codable {
    let hits: [Hit]
    let nbHits, processingTimeMS: Int
    let query: String
    let params: String
    let degradedQuery: Bool
}

// MARK: - Hit
struct Hit: Codable {
    let country: String
    let isCountry, isHighway: Bool
    let importance: Int
//    let tags: [Tag]
    let postcode, county: [String]?
    let population: Int
    let countryCode: String
    let isCity, isPopular: Bool
    let administrative: [String]
    let adminLevel: Int
    let isSuburb: Bool
    let localeNames: [String]
    let geoloc: Geoloc
    let objectID: String
    let highlightResult: HighlightResult

    enum CodingKeys: String, CodingKey {
        case country
        case isCountry = "is_country"
        case isHighway = "is_highway"
        case importance
//        case tags = "_tags"
        case postcode, county, population
        case countryCode = "country_code"
        case isCity = "is_city"
        case isPopular = "is_popular"
        case administrative
        case adminLevel = "admin_level"
        case isSuburb = "is_suburb"
        case localeNames = "locale_names"
        case geoloc = "_geoloc"
        case objectID
        case highlightResult = "_highlightResult"
    }
}

//enum CountryEnum: String, Codable {
//    case india = "India"
//}
//
//enum CountryCode: String, Codable {
//    case countryCodeIn = "in"
//}

// MARK: - Geoloc
struct Geoloc: Codable {
    let lat, lng: Double
}

// MARK: - HighlightResult
struct HighlightResult: Codable {
    let country: CountryElement
    let postcode, county: [CountryElement]?
    let administrative, localeNames: [CountryElement]

    enum CodingKeys: String, CodingKey {
        case country, postcode, county, administrative
        case localeNames = "locale_names"
    }
}

// MARK: - CountryElement
struct CountryElement: Codable {
    let value: String
    let matchLevel: MatchLevel
    let matchedWords: [String]
    let fullyHighlighted: Bool?
}

enum MatchLevel: String, Codable {
    case full
    case none
}

enum Tag: String, Codable {
    case city = "city"
    case countryIn = "country/in"
    case place = "place"
    case placeCity = "place/city"
    case placeTown = "place/town"
    case placeVillage = "place/village"
    case sourceGeonames = "source/geonames"
    case sourceOsm = "source/osm"
}
