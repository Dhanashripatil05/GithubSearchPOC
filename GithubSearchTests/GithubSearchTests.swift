//
//  GithubSearchTests.swift
//  GithubSearchTests
//
//  Created by Dhanashri on 15/11/21.
//

import XCTest
@testable import GithubSearch

class GithubSearchTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    //Covered unit test cases for service logic only. Textfield validation in depth covered in UI test case.
    func testRepoModelHasRequiredFields() {
        let model = Repo(id: 1, owner: Owner(login: "ABC", avatar_url: "Swiftify"), name: "Swift", open_issues: 245, score: 1, language: "Swift", url: "https://api.github.com/users/tensorflow/repos")
        XCTAssertNotNil(model)
    }
    
    func testSearchBefore() {
        let sut = SearchService()
        
        sut.getGithubSearchRepos("swift", page: 1) { _ in }
        let urlString = Constants.BASE_URL + "swift&page=1&per_page=20"
        
        let lastRequest = URLSession.shared.tasks.last?.currentRequest
        XCTAssertEqual(lastRequest?.url, URL(string: urlString)!)
       
    }
        
    func testTextFielsValidPhrase() {
        let sut = ViewController()
        sut.loadViewIfNeeded()
        
        let urlString = Constants.BASE_URL + "Swift.&page=1&per_page=20"
        sut.validateString(enteredText: "Swift.", pageNumber: 1)
        
        let lastRequest = URLSession.shared.tasks.last?.currentRequest
        XCTAssertEqual(lastRequest?.url, URL(string: urlString)!)
    }
    
    func testTextFielsInValidPhrase() {
        let sut = ViewController()
        sut.loadViewIfNeeded()
        
        let urlString = Constants.BASE_URL + "Swift$&page=1&per_page=20"
        sut.validateString(enteredText: "Swift$", pageNumber: 1)
        
        let lastRequest = URLSession.shared.tasks.last?.currentRequest
        XCTAssertNotEqual(lastRequest?.url, URL(string: urlString)!)
    }
    
    func testTextFielsValidPhraseLength() {
        let sut = ViewController()
        sut.loadViewIfNeeded()
        
        let urlString = Constants.BASE_URL + "Swift9&page=1&per_page=20"
        sut.validateString(enteredText: "Swift9", pageNumber: 1)
        
        let lastRequest = URLSession.shared.tasks.last?.currentRequest
        XCTAssertEqual(lastRequest?.url, URL(string: urlString)!)
    }
    
    func testTextFielsInValidPhraseLength() {
        let sut = ViewController()
        sut.loadViewIfNeeded()
        
        let urlString = Constants.BASE_URL + "Swi&page=1&per_page=20"
        sut.validateString(enteredText: "Swi", pageNumber: 1)
        
        let lastRequest = URLSession.shared.tasks.last?.currentRequest
        XCTAssertNotEqual(lastRequest?.url, URL(string: urlString)!)
    }
    
    func testSearchAfterWithValidJSON() {
        let expectedRepo = ["items": [
                                Repo(id: 1, owner: Owner(login: "ABC", avatar_url: "Swiftify"), name: "Swift", open_issues: 245, score: 1, language: "Swift", url: "https://api.github.com/users/tensorflow/repos"),
                                Repo(id: 1, owner: Owner(login: "ABC", avatar_url: "Swiftify"), name: "Swift", open_issues: 245, score: 1, language: "Swift", url: "https://api.github.com/users/tensorflow/repos")
                               ]]
        let encoder = JSONEncoder()
        let data = try! encoder.encode(expectedRepo)
       
        let sut = SearchService()
        
        let result = sut.parseData(withData: data)
        XCTAssertEqual(result.count, expectedRepo["items"]?.count)
    }

    func testSearchAfterWithInvalidJson() {
        let expectedRepo = [[
                                Repo(id: 1, owner: Owner(login: "ABC", avatar_url: "Swiftify"), name: "Swift", open_issues: 245, score: 1, language: "Swift", url: "https://api.github.com/users/tensorflow/repos"),
                                Repo(id: 1, owner: Owner(login: "ABC", avatar_url: "Swiftify"), name: "Swift", open_issues: 245, score: 1, language: "Swift", url: "https://api.github.com/users/tensorflow/repos")
                           ]]
        let encoder = JSONEncoder()
        let data = try! encoder.encode(expectedRepo)
       
        let sut = SearchService()
        
        let result = sut.parseData(withData: data)
        XCTAssertNotEqual(result.count, expectedRepo.count)
    }
}

extension URLSession {
    var tasks: [URLSessionTask] {
        var tasks: [URLSessionTask] = []
        let group = DispatchGroup()
        group.enter()
        getAllTasks {
            tasks = $0
            group.leave()
        }
        group.wait()
        return tasks
    }
}
