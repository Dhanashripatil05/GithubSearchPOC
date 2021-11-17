//
//  ViewController.swift
//  GithubSearch
//
//  Created by Dhanashri on 15/11/21.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var tableView: UITableView?
    @IBOutlet var textfield: UITextField?
    
    let refreshControl = UIRefreshControl()
    let spineer = UIActivityIndicatorView()
    var repos = [Repo]()
    var currentPageNumber = 0
    var isPageRefreshing = false
  

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.accessibilityIdentifier = Constants.TABLE_IDENTIFIER
        textfield?.delegate = self
        tableView?.delegate = self
        tableView?.dataSource = self
        self.registerTableViewCells()
        
        currentPageNumber = 1
        
        //Pull to refresh
        refreshControl.attributedTitle = NSAttributedString(string: Constants.PULL_TO_REFRESH )
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView?.addSubview(refreshControl)
    }

    //MARK:- Pull to refresh handler
    @objc func refresh(_ sender: AnyObject) {
        requestGithubRepo(forEndpoint: textfield?.text, page: currentPageNumber)
        self.refreshControl.endRefreshing()
    }
    
    //MARK:- TextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.repos.removeAll()
        validateString(enteredText: textfield?.text, pageNumber: currentPageNumber)
        return true
    }
    
    //MARK:- TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.IDENTIFIER) as? RepoTableViewCell {
            if repos.count != 0 {
                cell.updateCell(withRepo: repos[indexPath.row])
            }
            return cell
        }
            
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let urlString = repos[indexPath.row].url as String? {
            guard let requestUrl = URL(string: urlString) else {
                return
            }
            let safariController = SFSafariViewController(url: requestUrl)
            present(safariController, animated: true)
        }
            
    }
    
    func registerTableViewCells() {
        let repoCell = UINib(nibName: Constants.Cell.IDENTIFIER,
                                  bundle: nil)
        tableView?.register(repoCell,
                           forCellReuseIdentifier: Constants.Cell.IDENTIFIER)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.tableView!.contentOffset.y >= (self.tableView!.contentSize.height - self.tableView!.bounds.size.height)) {
            if !isPageRefreshing {
                isPageRefreshing = true
                
                spineer.startAnimating()
                spineer.color = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
                spineer.hidesWhenStopped = true
                tableView?.tableFooterView = spineer
                currentPageNumber = currentPageNumber + 1
                
                requestGithubRepo(forEndpoint: textfield?.text, page: currentPageNumber)
            }
        }
    }
    
    //MARK:- Valdation
    func validateString(enteredText: String?, pageNumber: Int)  {
        do {
            guard let text = enteredText, !text.isEmpty else {
                return
            }
            
            if text.count > 30 {
                AlertView.showAlert(view: self, message: Constants.MAX_CHARACTER_ERROR)
                return
            } else if text.count < 4 {
                AlertView.showAlert(view: self, message: Constants.MIN_CHARACTER_ERROR)
                return
            }
            
            let format = Constants.Regex.FORMAT
            
            let predicate = NSPredicate(format:Constants.Regex.PREDICATE, format)
            if !(predicate.evaluate(with: text)) {
                AlertView.showAlert(view: self, message: Constants.Regex.REGEX_ERROR)
            } else {
                self.requestGithubRepo(forEndpoint: text, page: pageNumber)
            }
        }
    }
    
    //MARK:- Request API
    func requestGithubRepo(forEndpoint enteredText: String?, page: Int) {
        textfield?.resignFirstResponder()
        
        guard let text = enteredText, !text.isEmpty else {
            return
        }
        
        //API call
        SearchService().getGithubSearchRepos(text, page: page) { (gitubRepos) in
            if gitubRepos.isEmpty {
                AlertView.showAlert(view: self, message: Constants.NO_DATA_FOUND)
            }
            self.repos.append(contentsOf: gitubRepos)
            DispatchQueue.main.async {
                self.spineer.stopAnimating()
                self.tableView?.reloadData()
            }
        }
    }

}

