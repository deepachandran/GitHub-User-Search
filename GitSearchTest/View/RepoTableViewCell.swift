//
//  RepoTableViewCell.swift
//  GitSearchTest
//
//  Created by Deepa & Aneesh on 4/2/20.
//  Copyright © 2020 Deepa Chandran. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var RepoNameLbl: UILabel!
    @IBOutlet weak var Forks: UILabel!
    @IBOutlet weak var Starlbl: UILabel!
    var url = String()
    
    
    func configureCell(repo: repo) {
        RepoNameLbl.text = repo.repoName
        Forks.text = "\(String(repo.numberOfForks)) Forks"
        Starlbl.text = "\(String(repo.numberOfStars)) Stars"
        url = String(repo.repoUrl)
      
    }
    
    
    
}
