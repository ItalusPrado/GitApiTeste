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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        fillInformation()
    }
    
    func fillInformation(){
        if let user = self.user{
            
            // Dados da label
            self.nameLabel.text = user.details?.name
            self.companyLabel.text = user.details?.company
            self.emailLabel.text = user.details?.email
            self.blogLabel.text = user.details?.blog
            self.locationLabel.text = user.details?.location
            
            // Download da imagem
            downloadImage()
        }
    }
    
    func downloadImage() {
        guard let urlPath = self.user?.avatar_url else {return}
        if let url = URL(string: urlPath){
            DispatchQueue.global().async {
                if let data = try? Data( contentsOf:url){
                    DispatchQueue.main.async {
                        self.profileImage.image = UIImage( data:data)
                    }
                }
            }
        }
    }

}
