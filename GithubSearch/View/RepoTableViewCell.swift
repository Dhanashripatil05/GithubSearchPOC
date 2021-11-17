//
//  RepoTableViewCell.swift
//  GithubSearch
//
//  Created by Dhanashri on 16/11/21.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var ownerAvtarImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var openIssuesLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var repoName: UILabel!
    var repoUrl: String?
    
    func updateCell(withRepo repo: Repo)
    {
        let url = URL(string: repo.owner.avatar_url)
        if let imageUrl = url {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageUrl)
                DispatchQueue.main.async {
                    self.ownerAvtarImageView.image = UIImage(data: data!)
                }
            }
        }
        ownerNameLabel.text = repo.owner.login
        languageLabel.text = Constants.Cell.LANGUAGE + repo.language
        repoName.text = Constants.Cell.REPO + repo.name
        openIssuesLabel.text = String(repo.open_issues)
        starsCountLabel.text = String(repo.score)
        repoUrl = repo.url
    }
        

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
