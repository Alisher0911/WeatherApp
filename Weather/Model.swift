//
//  Model.swift
//  Weather
//
//  Created by Alisher on 2/10/21.
//  Copyright © 2021 Alisher. All rights reserved.
//

import Foundation

public struct Model: Codable{
    let timezone: String?
    let hourly: [Current]?
    let daily: [Daily]?
    let current: Current?
    let name: String?
}

struct Current: Codable {
    let temp: Double?
    let feels_like: Double?
    let weather: [Weather]?
}

struct Daily: Codable {
    let dt: Int
    let temp: Temp?
    let feels_like: Temp?
    let weather: [Weather]?
}

struct Temp: Codable {
    let day: Double?
}

struct Weather: Codable {
    let main: String?
    let description: String?
}
