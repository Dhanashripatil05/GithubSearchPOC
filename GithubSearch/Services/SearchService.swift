//
//  SearchService.swift
//  GithubSearch
//
//  Created by Dhanashri on 15/11/21.
//

import Foundation

struct SearchService {
   
    func getGithubSearchRepos(_ endpoint: String, page: Int, completion: @escaping ([Repo]) -> ()) {

        let urlString = Constants.BASE_URL + endpoint + Constants.PAGE_NUMBER + String(page) + Constants.PAGE_COUNT
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.addValue(Constants.ACCEPT_VALUE, forHTTPHeaderField: Constants.ACCEPT)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            completion(parseData(withData: data))
    
        }.resume()
    }
    
    func parseData(withData data: Data?) -> [Repo] {
        
        var searchedRepos = [Repo]()
        var repoID: Int!
        var ownersName: String!
        var ownersImage: String!
        var githubRepoName: String!
        var issuesCount: Int!
        var starsCount: Int!
        var programmingLang: String!
        var repoUrl: String!
        
        guard let repoData = data else { return [] }
        let json = try! JSONSerialization.jsonObject(with: repoData, options: .allowFragments) as? [String: Any]

        if let jsonData = json {
            if  let data = jsonData[Constants.Json.ITEMS] as? [[String: Any]] {
                for item in data  {
                    if let object = item as [String: Any]? {
                        // ID
                        if let id = object[Constants.Json.ID] as? Int {
                            repoID = id
                        }
                        
                        if let owner = object[Constants.Json.OWNER] as? [String: Any] {
                            // owner Name
                            let name = owner[Constants.Json.OWNER_NAME] as? String ?? Constants.NA
                            ownersName  = name
                           
                            // Avtar Image
                            let imageString = owner[Constants.Json.OWNER_IMAGE] as? String ?? Constants.NA
                            ownersImage = imageString
                            
                            // Repo name
                            let repoName = object[Constants.Json.REPO] as? String ?? Constants.NA
                            githubRepoName = repoName
                            
                            // Issues count
                            let count = object[Constants.Json.ISSUES_COUNT] as? Int
                            issuesCount = count
                            
                            // stars count
                            let stars = object[Constants.Json.STARS_COUNT] as? Int
                            starsCount = stars
                            
                            // programming language
                            let language = object[Constants.Json.LANGUAGE] as? String ?? Constants.NA
                            programmingLang = language
                            
                            //Repo url
                            let repoUrlString = object[Constants.Json.REPO_URL] as? String ?? Constants.NA
                            repoUrl = repoUrlString
                        }
                        
                        searchedRepos.append(Repo(id: repoID, owner: Owner(login: ownersName, avatar_url: ownersImage), name: githubRepoName, open_issues: issuesCount, score: starsCount, language: programmingLang, url: repoUrl))
                    }
                }
            }
            
        }  else {
            print(Constants.Error.INVALID_JSON)
        }

        return searchedRepos
    }
}
