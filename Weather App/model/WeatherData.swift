//
//  WeatherData.swift
//  Weather App
//
//  Created by Mukesh Maurya on 12/02/24.
//

import Foundation
struct WeatherData : Codable {
    let coord : Coord?
    let weather : [Weather]?
    let base : String?
    let main : Main?
    let visibility : Int?
    let clouds : Clouds?
    let dt : Int?
    let timezone : Int?
    let id : Int?
    let name : String?
    let cod : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case coord = "coord"
        case weather = "weather"
        case base = "base"
        case main = "main"
        case visibility = "visibility"
        case clouds = "clouds"
        case dt = "dt"
        case timezone = "timezone"
        case id = "id"
        case name = "name"
        case cod = "cod"
    }
}

struct Clouds : Codable {
    let all : Int?
    
    enum CodingKeys: String, CodingKey {
        case all = "all"
    }
    
}

struct Coord : Codable {
    let lon : Double?
    let lat : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case lon = "lon"
        case lat = "lat"
    }
    
}

struct Main : Codable {
    let temp : Double?
    let feelsLike : Double?
    let tempMin : Double?
    let tempMax : Double?
    let pressure : Int?
    let humidity : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case temp = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}

struct Weather : Codable {
    let id : Int?
    let main : String?
    let description : String?
    let icon : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
    
    func getIcon() -> String{
        print(self)
        return switch main{
        case "Clear" : "sun.max.fill"
        case "Clouds" : "cloud.fill"
        case "Thunderstorm" : "cloud.bolt.rain.fill"
        case "Drizzle" : "cloud.drizzle.fill"
        case "Rain" : "cloud.rain.fill"
        case "Snow" : "cloud.snow.fill"
        case "Fog" : "cloud.fog.fill"
        case "Haze" : "sun.haze.fill"
        case "Dust" : "sun.dust.fill"
        case "Smoke" : "smoke.fill"
        default : "cloud.sun.fill"
        }
    }
}
