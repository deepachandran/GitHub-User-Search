//
//  UserCell.swift
//  GitSearchTest
//
//  Created by Deepa & Aneesh on 4/1/20.
//  Copyright © 2020 Deepa Chandran. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var numberOfRepo: UILabel!
    
    func configureCell(user: User) {
        userName.text = user._name
        //print(userName.text)
        //let defaultUrl = URL(string: "https://avatars1.githubusercontent.com/u/63057134?v=4")!
        //guard let defaultData = try? Data(contentsOf: defaultUrl) else { return nil }
        let url = URL(string: user._avatarUrl)
        if let data = try? Data(contentsOf: url!)
        {
            let image: UIImage = UIImage(data: data)!
            self.userImage.image = image
        }
    }

    
}
