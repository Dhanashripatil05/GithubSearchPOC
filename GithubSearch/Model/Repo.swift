//
//  SearchResults.swift
//  GithubSearch
//
//  Created by Dhanashri on 15/11/21.
//

import Foundation

struct Repo: Codable {
    let id: Int
    let owner: Owner
    let name: String
    let open_issues: Int
    let score: Int
    let language: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case owner
        case open_issues
        case name
        case score
        case language
        case url
    }
}


struct Owner: Codable {
    let login: String
    let avatar_url: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatar_url
    }
}
