//
//  Contacts.swift
//  MyContact
//
//  Created by Alwi Shihab on 21/11/22.
//

import Foundation

struct ContactListResponse: Codable{
    let results: [Contacts]
}

struct Contacts: Codable{
    let gender: String?
    let name: Name
    let location: Location
    let email: String?
    let dob: Dob
    let registered: Registered
    let phone: String?
    let cell: String?
    let id: Id
    let picture: Picture
    let nat: String?
}

struct Name: Codable{
    let title: String?
    let first: String?
    let last: String?
}

struct Location: Codable{
    let street: Street
    let city: String?
    let state: String?
    let country: String?
    let postcode: Int?
    let coordinates: Coordinate
    let timezone: Timezone
    
}

struct Street: Codable{
    let number: Int?
    let name: String?
}

struct Coordinate: Codable{
    let latitude: String?
    let longitude: String?
}

struct Timezone: Codable{
    let offset: String?
    let description: String?
}

struct Dob: Codable{
    let date: String?
    let age: Int?
}

struct Registered: Codable{
    let date: String?
    let age: Int?
}

struct Id: Codable{
    let name: String?
    let value: String?
}

struct Picture: Codable{
    let large: String?
    let medium: String?
    let thumbnail: String?
}
