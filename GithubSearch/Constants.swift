//
//  Constants.swift
//  GithubSearch
//
//  Created by Dhanashri on 15/11/21.
//

import Foundation

struct Constants {
    static let BASE_URL = "https://api.github.com/search/repositories?q="
    static let ACCEPT_VALUE = "application/vnd.github.v3+json"
    static let ACCEPT = "Accept"
    static let ALERT_TITLE = "Error"
    static let ALERT_BUTTON = "OK"
    static let MAX_CHARACTER_ERROR = "Search phrase should be less than or equal to 30 characters."
    static let MIN_CHARACTER_ERROR = "Search phrase should contain at least 4 characters."
    static let NA = "N/A"
    static let PULL_TO_REFRESH = "Pull to refresh"
    static let PAGE_NUMBER = "&page="
    static let PAGE_COUNT = "&per_page=20"
    static let NO_DATA_FOUND = "No data found."
    static let TABLE_IDENTIFIER = "tableView"
    
    struct Json {
        static let ITEMS = "items"
        static let ID = "id"
        static let OWNER = "owner"
        static let OWNER_NAME = "login"
        static let OWNER_IMAGE = "avatar_url"
        static let ISSUES_COUNT = "open_issues"
        static let STARS_COUNT = "score"
        static let LANGUAGE = "language"
        static let JSON = "json"
        static let FILE = "data"
        static let REPO = "name"
        static let REPO_URL = "html_url"
    }
    
    struct Error {
        static let INVALID_JSON = "JSON is invalid."
        static let NO_FILE = "File not found."
    }
    
    struct Cell {
        static let IDENTIFIER = "RepoTableViewCell"
        static let LANGUAGE = "Language:- "
        static let REPO = "Repo:- "
    }
    
    struct Regex {
        static let FORMAT = "^[a-zA-Z0-9\\_\\-\\.\\/]+$"
        static let PREDICATE = "SELF MATCHES %@"
        static let REGEX_ERROR = "Please check entered phrase again for special characters"
    }
}
