//
//  DetailsViewController.swift
//  GitApiTeste
//
//  Created by Italus Rodrigues do Prado on 12/03/19.
//  Copyright © 2019 Italus Rodrigues do Prado. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var user: User?
    var loginNick: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func fillInformation(){
        
    }

}
